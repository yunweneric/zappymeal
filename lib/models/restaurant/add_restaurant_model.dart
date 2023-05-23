import 'dart:convert';

import 'package:zappy_meal/models/locations/add_location_model.dart';

AddRestaurantReqModel addRestaurantReqModelFromJson(String str) => AddRestaurantReqModel.fromJson(json.decode(str));

String addRestaurantReqModelToJson(AddRestaurantReqModel data) => json.encode(data.toJson());

class AddRestaurantReqModel {
  AddRestaurantReqModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.country,
    required this.costPerKm,
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final DateTime createdAt;
  final AddLocationReqModel location;
  final String description;
  String imageUrl;
  final int costPerKm;
  final AppCountry country;

  factory AddRestaurantReqModel.fromJson(Map<String, dynamic> json) => AddRestaurantReqModel(
        id: json["id"],
        name: json["name"],
        costPerKm: json["costPerKm"],
        country: AppCountry.fromJson(json["country"]),
        phone: json["phone"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        location: AddLocationReqModel.fromJson(json["location"]),
        description: json["description"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "costPerKm": costPerKm,
        "country": country.toJson(),
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "location": location.toJson(),
        "description": description,
        "imageUrl": imageUrl,
      };
}

class AppCountry {
  final String name;
  final String? isoCode;
  final String? iso3Code;
  final String? phoneCode;
  final String currencyCode;
  final String currencyName;

  AppCountry({
    this.isoCode,
    this.iso3Code,
    this.phoneCode,
    required this.name,
    required this.currencyCode,
    required this.currencyName,
  });

  factory AppCountry.fromJson(Map<String, dynamic> json) => AppCountry(
        name: json['name'],
        isoCode: json['isoCode'],
        iso3Code: json['iso3Code'],
        phoneCode: json['phoneCode'],
        currencyCode: json['currencyCode'],
        currencyName: json['currencyName'],
      );
  Map<String, dynamic> toJson() => {
        'name': name,
        'isoCode': isoCode,
        'iso3Code': iso3Code,
        'phoneCode': phoneCode,
        'currencyCode': currencyCode,
        'currencyName': currencyName,
      };
}
