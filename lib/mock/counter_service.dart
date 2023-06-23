import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/services/base_service.dart';

class MockCounterService extends BaseService {
  Future<AppBaseReponse> getRestaurantAdminCount(BuildContext context) async {
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "message", data: {"data": MockData.restaurantAdminCount});
  }

  Future<AppBaseReponse> getAdminCount(BuildContext context) async {
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "message", data: {"data": MockData.adminCounts});
  }

  Future<AppBaseReponse> getDispatchersCount(BuildContext context) async {
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "message", data: {"data": MockData.dispatchersCount});
  }
}
