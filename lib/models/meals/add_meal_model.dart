import 'dart:convert';

import 'package:zappy_meal/models/categories/add_category_model.dart';
import 'package:zappy_meal/models/restaurant/add_restaurant_model.dart';

AddMealReqModel? addMealReqModelFromJson(String str) => AddMealReqModel.fromJson(json.decode(str));

String addMealReqModelToJson(AddMealReqModel? data) => json.encode(data!.toJson());

class AddMealReqModel {
  AddMealReqModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.quantity,
    required this.restaurantId,
    required this.category,
    required this.imageUrl,
    required this.createdAt,
    required this.restaurant,
    this.userId,
    required this.updatedAt,
    required this.status,
    required this.categoryId,
  });

  String id;
  int? quantity;
  String name;
  String price;
  String categoryId;
  String description;
  String restaurantId;
  AddRestaurantReqModel restaurant;
  AddCategoryReqModel category;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  String? userId;

  factory AddMealReqModel.fromJson(Map<String, dynamic> json) => AddMealReqModel(
        id: json["id"],
        quantity: json["quantity"],
        name: json["name"],
        price: json["price"],
        categoryId: json["categoryId"],
        description: json["description"],
        restaurantId: json["restaurantId"],
        category: AddCategoryReqModel.fromJson(json["category"]),
        imageUrl: json["imageUrl"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        status: json["status"],
        userId: json["userId"],
        restaurant: AddRestaurantReqModel.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "restaurantId": restaurantId,
        "category": category.toJson(),
        "imageUrl": imageUrl,
        "created_at": createdAt,
        "categoryId": categoryId,
        "quantity": quantity,
        "userId": userId,
        "updated_at": updatedAt,
        "restaurant": restaurant.toJson(),
        "status": status,
      };
}
