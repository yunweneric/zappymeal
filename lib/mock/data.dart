import 'dart:math';

import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import 'package:zappy_meal/models/categories/add_category_model.dart';
import 'package:zappy_meal/models/counter/counter_model.dart';
import 'package:zappy_meal/models/locations/add_location_model.dart';
import 'package:zappy_meal/models/login/login_res_model.dart';
import 'package:zappy_meal/models/login/verification_res_model.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/models/payment/psp_model.dart';
import 'package:zappy_meal/models/restaurant/add_restaurant_model.dart';
import 'package:zappy_meal/shared/utils/index.dart';

class MockData {
  static AddCategoryReqModel category = AddCategoryReqModel(
    id: Uuid().v1(),
    name: "Category name",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl: "",
  );

  static AppCountry country = AppCountry(
    name: "Country name",
    currencyCode: "FCFA",
    currencyName: "Francs CFA",
  );

  static AddLocationReqModel location = AddLocationReqModel(
    latitude: 20.0,
    longitude: -10.0,
    user_id: Uuid().v4(),
    locationName: "Location Name",
    createdAt: DateTime.now(),
    id: Uuid().v4(),
    isApproved: true,
  );
  static AddRestaurantReqModel restaurant = AddRestaurantReqModel(
    id: Uuid().v4(),
    name: "Restaurant name",
    phone: "",
    email: "restaurant@gmail.com",
    createdAt: DateTime.now(),
    location: location,
    description: "This is the restaurant description",
    imageUrl: "",
    country: country,
    costPerKm: 500,
  );
  static AddMealReqModel meal(Faker faker) => AddMealReqModel(
        id: Uuid().v4(),
        name: faker.food.dish(),
        price: faker.randomGenerator.integer(1200, min: 1000).toString(),
        description: faker.lorem.words(400).join(" "),
        restaurantId: "",
        category: category,
        imageUrl: faker.image.image(keywords: ['food', "cheese", "cake", "burger", "soup"]),
        createdAt: DateTime.now(),
        restaurant: restaurant,
        quantity: faker.randomGenerator.integer(30, min: 1),
        updatedAt: DateTime.now(),
        status: "un_available",
        categoryId: Uuid().v4(),
      );

  static List<PSPModel> psp = [
    PSPModel(
      id: Uuid().v1(),
      name: "Momo",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      imageUrl: ImageAssets.momo,
    ),
    PSPModel(
      id: Uuid().v1(),
      name: "Orange Money",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      imageUrl: ImageAssets.om,
    ),
    PSPModel(
      id: Uuid().v1(),
      name: "Credit Card",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      imageUrl: ImageAssets.card,
    ),
  ];
  static VerificationResponse verificationData(role) => VerificationResponse(
        id: Uuid().v1(),
        name: faker.person.firstName(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        imageUrl: "https://randomuser.me/api/portraits/women/${Random().nextInt(100)}.jpg",
        token: faker.jwt.secret,
        role: UserRole(id: Uuid().v1(), name: role),
      );

  static LoginResponseModel loginData = LoginResponseModel(
    id: Uuid().v1(),
    name: faker.person.firstName(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    code: faker.randomGenerator.numberOfLength(4),
  );

  static List<CounterModel> adminCounts = [
    CounterModel(value: 20000, title: "Income"),
    CounterModel(value: 920, title: "Users"),
    CounterModel(value: 104, title: "Restaurants"),
    CounterModel(value: 124, title: "Meals"),
    CounterModel(value: 5, title: "Orders"),
    CounterModel(value: 5, title: "Dispatchers"),
  ];
  static List<CounterModel> dispatchersCount = [
    CounterModel(value: 50000, title: "Income"),
    CounterModel(value: 920, title: "Pending Orders"),
    CounterModel(value: 104, title: "Active Orders"),
    CounterModel(value: 124, title: "Delivered Orders"),
    CounterModel(value: 124, title: "Delivered Orders"),
  ];
  static List<CounterModel> restaurantAdminCount = [
    CounterModel(value: 3000, title: "Income"),
    CounterModel(value: 920, title: "Meals"),
    CounterModel(value: 104, title: "Pending Orders"),
    CounterModel(value: 124, title: "Approved Orders"),
    CounterModel(value: 124, title: "Active Orders"),
    CounterModel(value: 124, title: "Canceled Orders"),
    CounterModel(value: 124, title: "Delivered Orders"),
  ];
}
