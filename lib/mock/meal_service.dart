import 'package:faker/faker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

import '../models/meals/add_meal_model.dart';
import '../services/base_service.dart';

class MockMealService extends BaseService {
  Future<AppBaseResponse> listMeals() async {
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "Meals successfully gotten", data: {"data": MockData.meals});
  }
}
