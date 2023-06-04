import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/locations/add_location_model.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/models/restaurant/add_restaurant_model.dart';
import 'package:zappy_meal/services/base_service.dart';
import 'package:zappy_meal/shared/components/alerts.dart';
import 'package:zappy_meal/shared/utils/local_storage.dart';
import 'package:zappy_meal/shared/utils/logger_util.dart';

class LocationApiService extends BaseService {
  Future<AppBaseReponse> saveDeliveryAddress(BuildContext context, AddLocationReqModel location) async {
    try {
      return apiSuccess(message: "Location saved successfully!", data: {});
    } catch (e) {
      logError("Error $e");
      return apiServerError();
    }
  }

  Future<AppBaseReponse> deleteLocation(BuildContext context, Map<String, dynamic> data) async {
    try {
      return apiSuccess(message: "Location deleted successfully!", data: {});
    } catch (e) {
      return apiServerError();
    }
  }

  Future editLocation(BuildContext context, Map<String, dynamic> data, String imageType, String imageUrl, String ref, String id) async {}

  Future<AppBaseReponse> updateLocationStatus(BuildContext context, String ref, bool status, String user_id) async {
    try {
      return apiSuccess(message: "Location updated successfully!", data: {});
    } catch (e) {
      logError(e);
      return apiServerError();
    }
  }

  Future<AddLocationReqModel> determineCurrentLocation({required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showErrorAlert(context: context, desc: "Permission Error!", title: "Please enable your location services");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showErrorAlert(context: context, desc: "Permission Error!", title: "Please enable your location services");
        permission = await Geolocator.requestPermission();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showErrorAlert(
        context: context,
        desc: "Permission Error!",
        title: "Please enable your location services",
        onOkay: () {
          Geolocator.openAppSettings();
        },
      );

      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return AddLocationReqModel(
      latitude: position.latitude,
      longitude: position.longitude,
      locationName: "",
      createdAt: DateTime.now(),
      id: "",
      isApproved: false,
      user_id: "",
    );
  }

  Future<List<AddLocationReqModel>> getAllApprovedDeliveryLocations() async {
    return [];
  }

  Future<AddLocationReqModel?> userCurrentLocationToFindClosestDeliveryLocation(context) async {
    AddLocationReqModel currentLocation = await this.determineCurrentLocation(context: context);
    List<AddLocationReqModel?> allApprovedLocations = await getAllApprovedDeliveryLocations();

    // * Getting distance of all approved delivery locations
    List<Map> myList = allApprovedLocations.map((e) {
      var distance = Geolocator.distanceBetween(currentLocation.latitude, currentLocation.longitude, e!.latitude, e.longitude);
      return {"distance": distance, "item": e};
    }).toList();

    // * Sorting all approved delivery locations
    myList.sort((a, b) => (b['distance']).compareTo(a['distance']));
    if (myList.length > 0) {
      AddLocationReqModel location = myList.last['item'];
      String? location_country = await getCountryFromCoordinates(location.latitude, location.longitude);
      String? user_country = await getCountryFromCoordinates(currentLocation.latitude, currentLocation.longitude);
      logI(["userCurrentLocationToFindClosestDeliveryLocation", location_country, user_country]);
      if (location_country != null && user_country != null && location_country.toLowerCase() == user_country.toLowerCase()) {
        return myList.last['item'];
      } else
        return null;
    } else {
      return null;
    }
  }

  static double getGeolocatorDistance({required context, required AddLocationReqModel initialLocation, required AddLocationReqModel endLocation}) {
    var distance = Geolocator.distanceBetween(initialLocation.latitude, initialLocation.longitude, endLocation.latitude, endLocation.longitude);
    return distance;
  }

  Future<AddLocationReqModel?> getDeliveryLocation(context) async {
    var userLocation = await LocalPrefs.getSavedLocation();
    // userLocation = null;
    if (userLocation == null || userLocation == '') {
      AddLocationReqModel? closestLocation = await this.userCurrentLocationToFindClosestDeliveryLocation(context);
      if (closestLocation != null) {
        await LocalPrefs.saveUserLocation(location: json.encode(closestLocation.toJson()));
        showInfoAlert(
          context: context,
          title: "Location added successfully",
          desc: "Your location was added successfully",
          btnOkOnPress: () {},
        );
        return closestLocation;
      }
      showInfoAlert(
        context: context,
        title: "Error addinng location",
        desc: "We encountered an error trying to add the location",
        btnOkOnPress: () {},
      );
      return null;
    } else {
      showInfoAlert(
        context: context,
        title: "Error addinng location",
        desc: "We encountered an error trying to add the location",
        btnOkOnPress: () {},
      );
      return AddLocationReqModel.fromJson(jsonDecode(userLocation));
    }
  }

  static List<AddRestaurantReqModel> getAllRestaturantsInRange({
    required List<AddRestaurantReqModel> allRestaurants,
    required BuildContext context,
    required AddLocationReqModel initialLocation,
    int? range,
  }) {
    return allRestaurants.where((element) {
      double distance = LocationApiService.getGeolocatorDistance(
        context: context,
        initialLocation: initialLocation,
        endLocation: AddLocationReqModel.fromJson(element.location.toJson()),
      );
      return range == null ? (distance / 1000) < 20 : (distance / 1000) < range;
    }).toList();
  }

  static List<AddMealReqModel> getAllMealsInRange({
    required List<AddMealReqModel> allMeals,
    required BuildContext context,
    required AddLocationReqModel initialLocation,
    int? range,
  }) {
    return allMeals.where((element) {
      double distance = LocationApiService.getGeolocatorDistance(
        context: context,
        initialLocation: initialLocation,
        endLocation: AddLocationReqModel.fromJson(element.restaurant.location.toJson()),
      );
      return range == null ? (distance / 1000) < 20 : (distance / 1000) < range;
    }).toList();
  }

  Future<AppBaseReponse> editDeliveryAddress(BuildContext context, AddLocationReqModel location) async {
    try {
      return apiSuccess(message: "services.location.s_updated", data: {});
    } catch (e) {
      logError("Error $e");
      return apiServerError();
    }
  }

  Future<String?> getCountryFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> place = await placemarkFromCoordinates(latitude, longitude);
      if (place.isNotEmpty) {
        return place[0].country;
      }
    } catch (e) {
      logI('getCountryFromCoordinates: $e');
      return null;
    }
    return null;
  }
}
