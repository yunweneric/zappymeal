// To parse this JSON data, do
//
//     final appUser = appUserFromJson(jsonString);

import 'dart:convert';

AppUser appUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String appUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser({
    required this.username,
    required this.uid,
    required this.phoneNumber,
    required this.photoUrl,
    required this.created_at,
    required this.updated_at,
    required this.token,
    required this.nToken,
    required this.role,
    this.date_of_birth,
  });

  final String username;
  final String uid;
  final String phoneNumber;
  final String photoUrl;
  final String token;
  final AppRole role;
  final List<String> nToken;
  final DateTime created_at;
  final DateTime updated_at;
  final DateTime? date_of_birth;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        username: json["username"],
        uid: json["uid"],
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoURL"],
        created_at: DateTime.parse(json["created_at"]),
        updated_at: DateTime.parse(json["updated_at"]),
        date_of_birth: json["date_of_birth"],
        role: AppRole.fromJson(json["role"]),
        token: json["token"],
        nToken: List<String>.from(json["nToken"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "phoneNumber": phoneNumber,
        "photoURL": photoUrl,
        "created_at": created_at.toIso8601String(),
        "updated_at": updated_at.toIso8601String(),
        "date_of_birth": date_of_birth?.toIso8601String(),
        "token": token,
        "role": role.toJson(),
        "nToken": List<String>.from(nToken.map((x) => x)),
      };
}

class AppRole {
  AppRole({
    required this.role,
    this.value,
  });

  final String role;
  final String? value;

  factory AppRole.fromJson(Map<String, dynamic> json) => AppRole(
        role: json["role"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "value": value,
      };
}
