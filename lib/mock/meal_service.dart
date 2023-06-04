import 'package:faker/faker.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

import '../models/meals/add_meal_model.dart';
import '../services/base_service.dart';

class MockMealService extends BaseService {
  Future<AppBaseReponse> listMeals() async {
    Faker faker = Faker();
    List<AddMealReqModel> meals = List.generate(10, (index) => meal(faker));

    return apiSuccess(message: "Meals successfully gotten", data: {"data": meals});
  }
}
