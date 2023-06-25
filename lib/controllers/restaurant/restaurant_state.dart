part of 'restaurant_cubit.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantGetInitial extends RestaurantState {}

class RestaurantGetError extends RestaurantState {
  final AppBaseResponse res;
  RestaurantGetError(this.res);
}

class RestaurantGetSuccess extends RestaurantState {
  final List<RestaurantModel> res;

  RestaurantGetSuccess(this.res);
}
