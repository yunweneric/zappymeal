import 'package:faker/faker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import '../services/base_service.dart';

class MockCartService extends BaseService {
  Future<AppBaseResponse> list_items() async {
    Faker faker = Faker();
    await Future.delayed(3000.ms, () {});
    List<Map<String, dynamic>> meals = List.generate(10, (index) => MockData.meal(faker).toJson());
    return apiSuccess(message: "Meals successfully gotten", data: {"data": meals});
  }
}
