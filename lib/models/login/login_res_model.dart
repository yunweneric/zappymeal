import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String code;
  String name;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
