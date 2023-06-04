part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentPSPListInit extends PaymentState {}

class PaymentPSPListError extends PaymentState {
  final AppBaseReponse res;

  PaymentPSPListError(this.res);
}

class PaymentPSPListSuccess extends PaymentState {
  final AppBaseReponse res;

  PaymentPSPListSuccess(this.res);
}
