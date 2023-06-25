import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/restaurant/restaurant_model.dart';
import 'package:zappy_meal/repositories/restaurant_repository.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantRepository repo = RestaurantRepository();
  RestaurantCubit() : super(RestaurantInitial());

  void fetchRestaurants(BuildContext context) async {
    emit(RestaurantInitial());
    try {
      AppBaseResponse res = await repo.fetchRestaurants(context);
      res.statusCode == 200 ? emit(RestaurantGetSuccess(res.data['data'])) : emit(RestaurantGetError(res));
    } catch (e) {
      emit(RestaurantGetError(repo.restaurant_service.apiServerError()));
    }
  }
}
