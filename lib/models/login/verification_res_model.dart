import 'dart:convert';

VerificationResponse verificationResponseFromJson(String str) => VerificationResponse.fromJson(json.decode(str));

String verificationResponseToJson(VerificationResponse data) => json.encode(data.toJson());

class VerificationResponse {
  VerificationResponse({
    required this.id,
    required this.name,
    required this.token,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.role,
  });

  String id;
  String name;
  String token;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  UserRole role;

  factory VerificationResponse.fromJson(Map<String, dynamic> json) => VerificationResponse(
        id: json["id"],
        name: json["name"],
        token: json["token"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["imageUrl"],
        role: UserRole.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "role": role.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserRole {
  UserRole({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
