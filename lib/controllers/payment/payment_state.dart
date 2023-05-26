part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentPSPListInit extends PaymentState {}

class PaymentPSPListError extends PaymentState {
  final BaseResponse res;

  PaymentPSPListError(this.res);
}

class PaymentPSPListSuccess extends PaymentState {
  final BaseResponse res;

  PaymentPSPListSuccess(this.res);
}
