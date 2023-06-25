import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';

AppBaseResponse AppBaseResponseFromJson(String str) => AppBaseResponse.fromJson(json.decode(str));

String AppBaseResponseToJson(AppBaseResponse data) => json.encode(data.toJson());

class AppBaseResponse {
  AppBaseResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final int statusCode;
  final String message;
  Map<String, dynamic> data;

  factory AppBaseResponse.fromJson(Map<String, dynamic> json) => AppBaseResponse(
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
