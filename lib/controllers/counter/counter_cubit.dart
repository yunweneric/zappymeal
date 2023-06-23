import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/counter/counter_model.dart';
import 'package:zappy_meal/repositories/counter_repository.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
  CounterRepository repo = CounterRepository();

  void getAdminCounts(BuildContext context) async {
    emit(CounterGetAdminCountInitial());
    try {
      AppBaseReponse res = await repo.getAdminCount(context);
      res.statusCode == 200 ? emit(CounterGetAdminCountSuccess(res.data['data'])) : emit(CounterGetAdminCountError(res));
    } catch (e) {
      emit(CounterGetAdminCountError(repo.auth_service.apiServerError()));
    }
  }

  void getRestaurantAdminCount(BuildContext context) async {
    emit(CounterGetAdminCountInitial());
    try {
      AppBaseReponse res = await repo.getRestaurantAdminCount(context);
      res.statusCode == 200 ? emit(CounterGetAdminCountSuccess(res.data['data'])) : emit(CounterGetAdminCountError(res));
    } catch (e) {
      emit(CounterGetAdminCountError(repo.auth_service.apiServerError()));
    }
  }

  void getDispatchersCount(BuildContext context) async {
    emit(CounterGetAdminCountInitial());
    try {
      AppBaseReponse res = await repo.getDispatchersCount(context);
      res.statusCode == 200 ? emit(CounterGetAdminCountSuccess(res.data['data'])) : emit(CounterGetAdminCountError(res));
    } catch (e) {
      emit(CounterGetAdminCountError(repo.auth_service.apiServerError()));
    }
  }
}
