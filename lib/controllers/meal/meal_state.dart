part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class MealListInit extends MealState {}

class MealListError extends MealState {
  final AppBaseResponse res;
  MealListError(this.res);
}

class MealListSuccess extends MealState {
  final List<MealModel> res;

  MealListSuccess(this.res);
}
