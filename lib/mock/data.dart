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
import 'package:zappy_meal/models/restaurant/restaurant_model.dart';
import 'package:zappy_meal/models/user/user_model.dart';
import 'package:zappy_meal/models/user/user_roles.dart';
import 'package:zappy_meal/shared/utils/index.dart';

class MockData {
  static AppUser user = AppUser(
    uid: Uuid().v1(),
    created_at: DateTime.now(),
    updated_at: DateTime.now(),
    nToken: [],
    role: AppRole(role: AppRoles.admin),
    phoneNumber: faker.phoneNumber.us(),
    photoUrl: faker.image.image(keywords: ['people', "avatar"]),
    token: faker.jwt.secret,
    username: faker.person.firstName(),
  );

  static AddCategoryReqModel category = AddCategoryReqModel(
    id: Uuid().v1(),
    name: "Category name",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl: "",
  );

  static AppCountry country = AppCountry(
    name: faker.address.country(),
    currencyCode: faker.currency.code(),
    currencyName: faker.currency.name(),
  );

  static AddLocationReqModel location(faker) => AddLocationReqModel(
        latitude: faker.geo.latitude(),
        longitude: faker.geo.longitude(),
        user_id: Uuid().v4(),
        locationName: faker.address.city(),
        createdAt: DateTime.now(),
        id: Uuid().v4(),
        isApproved: faker.randomGenerator.boolean(),
      );

  static RestaurantModel restaurant(faker) => RestaurantModel(
        id: Uuid().v4(),
        name: faker.company.name(),
        phone: faker.phoneNumber.us(),
        email: faker.internet.email(),
        createdAt: DateTime.now(),
        location: location(faker),
        description: faker.lorem.words(30).join(' '),
        imageUrl: faker.image.image(keywords: ['food', "cheese", "cake", "burger", "soup"]),
        country: country,
        costPerKm: 500,
      );

  static List<RestaurantModel> restaurants = List.generate(20, (index) => restaurant(faker));

  static List<MealModel> meals = List.generate(20, (index) => meal(faker));

  static MealModel meal(Faker faker) => MealModel(
        id: Uuid().v4(),
        name: faker.food.dish(),
        price: faker.randomGenerator.integer(1200, min: 1000).toString(),
        description: faker.lorem.words(400).join(" "),
        restaurantId: Uuid().v1(),
        category: category,
        imageUrl: faker.image.image(keywords: ['food', "cheese", "cake", "burger", "soup"]),
        createdAt: DateTime.now(),
        restaurant: restaurant(faker),
        quantity: faker.randomGenerator.integer(30, min: 1),
        updatedAt: DateTime.now(),
        isAvailable: faker.randomGenerator.boolean(),
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
    CounterModel(value: faker.randomGenerator.integer(200000), title: "Income"),
    CounterModel(value: faker.randomGenerator.integer(400), title: "Users"),
    CounterModel(value: faker.randomGenerator.integer(30), title: "Restaurants"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Meals"),
    CounterModel(value: 5, title: "Orders"),
    CounterModel(value: 5, title: "Dispatchers"),
  ];
  static List<CounterModel> dispatchersCount = [
    CounterModel(value: faker.randomGenerator.integer(70000), title: "Income"),
    CounterModel(value: faker.randomGenerator.integer(400), title: "Pending Orders"),
    CounterModel(value: faker.randomGenerator.integer(30), title: "Active Orders"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Delivered Orders"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Delivered Orders"),
  ];
  static List<CounterModel> restaurantAdminCount = [
    CounterModel(value: faker.randomGenerator.integer(80000), title: "Income"),
    CounterModel(value: faker.randomGenerator.integer(400), title: "Meals"),
    CounterModel(value: faker.randomGenerator.integer(30), title: "Pending Orders"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Approved Orders"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Active Orders"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Canceled Orders"),
    CounterModel(value: faker.randomGenerator.integer(86), title: "Delivered Orders"),
  ];
}
