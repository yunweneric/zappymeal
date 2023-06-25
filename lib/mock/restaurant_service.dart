import 'package:faker/faker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/services/base_service.dart';

class MockRestaurantService extends BaseService {
  Faker faker = new Faker();

  Future<AppBaseResponse> fetchRestaurants(BuildContext context) async {
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "verification successful", data: {"data": MockData.restaurants});
  }
}
