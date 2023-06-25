part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentPSPListInit extends PaymentState {}

class PaymentPSPListError extends PaymentState {
  final AppBaseResponse res;

  PaymentPSPListError(this.res);
}

class PaymentPSPListSuccess extends PaymentState {
  final AppBaseResponse res;

  PaymentPSPListSuccess(this.res);
}
