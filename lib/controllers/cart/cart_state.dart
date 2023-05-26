part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartListInit extends CartState {}

class CartListError extends CartState {
  final BaseResponse res;
  CartListError(this.res);
}

class CartListSuccess extends CartState {
  final BaseResponse res;

  CartListSuccess(this.res);
}
