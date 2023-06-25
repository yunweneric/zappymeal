import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/mock/restaurant_service.dart';

class RestaurantRepository {
  MockRestaurantService restaurant_service = MockRestaurantService();

  fetchRestaurants(BuildContext context) {
    return restaurant_service.fetchRestaurants(context);
  }
}
