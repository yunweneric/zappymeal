import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zappy_meal/shared/components/avatar_circle.dart';
import 'package:zappy_meal/shared/components/bottom_sheets.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/logger_util.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool? _serviceEnabled;
  Position? _userLocation;
  Set<Marker> _markers = {};

  String lat = "0";
  String long = "0";

  initstate() {
    // showRestaurantBottomSheet();
    super.initState();
  }

  Future<Widget> showRestaurantBottomSheet() {
    return AppBottomSheet.simpleSheet(
      context: context,
      height: kheight(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    ActionChip(label: Text("Nearby")),
                    ActionChip(label: Text("Popular")),
                  ],
                ),
              ),
              Text("See All")
            ],
          ),
          Container(
            height: 300.h,
            child: ListView.builder(itemBuilder: (context, index) {
              return Container();
            }),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () => AppBottomSheet.baseBottomSheet(context: context, child: Container())),
      // bottomSheet: showRestaurantBottomSheet(),
      appBar: AppBar(
        leadingWidth: 50.w,
        leading: Container(
          width: 20.w,
          height: 20.w,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 15.r,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              radius: 20.r,
              child: SvgPicture.asset(AppIcons.menu),
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 20.r,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              radius: 18.r,
              child: SvgPicture.asset(AppIcons.filter),
            ),
          ),
          kwSpacer(10.w),
          avatarCircle(context: context, radius: 19.r, circleColor: Theme.of(context).primaryColor),
          kwSpacer(10.w),
        ],
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        child: GoogleMap(
          markers: _markers,
          // minMaxZoomPreference: MinMaxZoomPreference(100.0, 200.0),
          onTap: (location) => {
            logI(location),
            setState(() {
              lat = location.latitude.toStringAsFixed(4);
              long = location.longitude.toStringAsFixed(4);
            })
          },
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) async {
            _mapController.complete(controller);

            //* Creates Marker on current user location, using a current icon.
            final userLocation = Marker(
              markerId: MarkerId('user-location'),
              icon: BitmapDescriptor.defaultMarker,
              position: _kGooglePlex.target,
            );

            setState(() => _markers.add(userLocation));
          },
        ),
      ),
    );
  }
}
