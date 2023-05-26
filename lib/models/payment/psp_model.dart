// To parse this JSON data, do
//
//     final PSPModel = PSPModelFromJson(jsonString);

import 'dart:convert';

PSPModel PSPModelFromJson(String str) => PSPModel.fromJson(json.decode(str));

String PSPModelToJson(PSPModel data) => json.encode(data.toJson());

class PSPModel {
  PSPModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  String id;
  String name;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;

  factory PSPModel.fromJson(Map<String, dynamic> json) => PSPModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
