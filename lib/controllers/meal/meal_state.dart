part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class MealListInit extends MealState {}

class MealListError extends MealState {
  final BaseResponse res;
  MealListError(this.res);
}

class MealListSuccess extends MealState {
  final BaseResponse res;

  MealListSuccess(this.res);
}
