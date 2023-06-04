part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartListInit extends CartState {}

class CartListError extends CartState {
  final AppBaseReponse res;
  CartListError(this.res);
}

class CartListSuccess extends CartState {
  final AppBaseReponse res;

  CartListSuccess(this.res);
}
