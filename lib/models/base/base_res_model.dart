// To parse this JSON data, do
//
//     final AppBaseReponse = AppBaseReponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';

AppBaseReponse AppBaseReponseFromJson(String str) => AppBaseReponse.fromJson(json.decode(str));

String AppBaseReponseToJson(AppBaseReponse data) => json.encode(data.toJson());

class AppBaseReponse {
  AppBaseReponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  Map<String, dynamic> data;

  factory AppBaseReponse.fromJson(Map<String, dynamic> json) => AppBaseReponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data,
      };

  googleLogin(BuildContext context) {}
}
