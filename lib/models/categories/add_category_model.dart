// To parse this JSON data, do
//
//     final addCategoryReqModel = addCategoryReqModelFromJson(jsonString);

import 'dart:convert';

AddCategoryReqModel addCategoryReqModelFromJson(String str) => AddCategoryReqModel.fromJson(json.decode(str));

String addCategoryReqModelToJson(AddCategoryReqModel data) => json.encode(data.toJson());

class AddCategoryReqModel {
  AddCategoryReqModel({
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

  factory AddCategoryReqModel.fromJson(Map<String, dynamic> json) => AddCategoryReqModel(
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
