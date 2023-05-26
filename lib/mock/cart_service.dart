import 'package:faker/faker.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import '../services/base_service.dart';

class MockCartService extends BaseService {
  Future<BaseResponse> list_items() async {
    Faker faker = Faker();
    List<Map<String, dynamic>> meals = List.generate(10, (index) => meal(faker).toJson());
    return apiSuccess(message: "Meals successfully gotten", data: {"data": meals});
  }
}
