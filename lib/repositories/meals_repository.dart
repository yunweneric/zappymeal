import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/mock/meal_service.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

class MealRepository {
  // MealService meal_service = new MealService();
  MockMealService meal_service = new MockMealService();
  Future<AppBaseResponse> list_meals(BuildContext context) async {
    return meal_service.listMeals();
  }
}
