import 'package:faker/faker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

import 'base_service.dart';

class MealService extends BaseService {
  Future<AppBaseResponse> listMeals() async {
    return await baseGet(urlPath: '');
  }
}
