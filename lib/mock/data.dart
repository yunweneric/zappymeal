import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';
import 'package:zappy_meal/models/categories/add_category_model.dart';
import 'package:zappy_meal/models/locations/add_location_model.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/models/payment/psp_model.dart';
import 'package:zappy_meal/models/restaurant/add_restaurant_model.dart';
import 'package:zappy_meal/shared/utils/index.dart';

AddCategoryReqModel category = AddCategoryReqModel(
  id: Uuid().v1(),
  name: "Category name",
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  imageUrl: "",
);

AppCountry country = AppCountry(
  name: "Country name",
  currencyCode: "FCFA",
  currencyName: "Francs CFA",
);

AddLocationReqModel location = AddLocationReqModel(
  latitude: 20.0,
  longitude: -10.0,
  user_id: Uuid().v4(),
  locationName: "Location Name",
  createdAt: DateTime.now(),
  id: Uuid().v4(),
  isApproved: true,
);
AddRestaurantReqModel restaurant = AddRestaurantReqModel(
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
AddMealReqModel meal(Faker faker) => AddMealReqModel(
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

List<PSPModel> psp = [
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
