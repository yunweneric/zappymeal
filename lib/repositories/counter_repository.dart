import 'package:flutter/material.dart';
import 'package:zappy_meal/mock/counter_service.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

class CounterRepository {
  MockCounterService auth_service = MockCounterService();

  Future<AppBaseReponse> getAdminCount(BuildContext context) {
    return auth_service.getAdminCount(context);
  }

  Future<AppBaseReponse> getRestaurantAdminCount(BuildContext context) {
    return auth_service.getRestaurantAdminCount(context);
  }

  Future<AppBaseReponse> getDispatchersCount(BuildContext context) {
    return auth_service.getDispatchersCount(context);
  }
}
