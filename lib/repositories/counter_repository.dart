import 'package:flutter/material.dart';
import 'package:zappy_meal/mock/counter_service.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

class CounterRepository {
  MockCounterService auth_service = MockCounterService();

  Future<AppBaseResponse> getAdminCount(BuildContext context) {
    return auth_service.getAdminCount(context);
  }

  Future<AppBaseResponse> getRestaurantAdminCount(BuildContext context) {
    return auth_service.getRestaurantAdminCount(context);
  }

  Future<AppBaseResponse> getDispatchersCount(BuildContext context) {
    return auth_service.getDispatchersCount(context);
  }
}
