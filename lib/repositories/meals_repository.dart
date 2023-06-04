import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/services/meal_service.dart';

class MealRepository {
  MealService meal_service = new MealService();
  Future<AppBaseReponse> list_meals(BuildContext context) async {
    return meal_service.listMeals();
  }
}
