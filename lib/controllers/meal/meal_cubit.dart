import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/services/base_service.dart';

import '../../repositories/meals_repository.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());
  MealRepository meal_repository = MealRepository();

  void list_meals(BuildContext context) async {
    emit(MealListInit());
    try {
      AppBaseReponse res = await meal_repository.list_meals(context);
      res.statusCode == 200 ? emit(MealListSuccess(res)) : emit(MealListError(res));
    } catch (e) {
      emit(MealListError(BaseService.serverError()));
    }
  }
}
