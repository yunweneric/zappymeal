part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class MealListInit extends MealState {}

class MealListError extends MealState {
  final AppBaseReponse res;
  MealListError(this.res);
}

class MealListSuccess extends MealState {
  final AppBaseReponse res;

  MealListSuccess(this.res);
}
