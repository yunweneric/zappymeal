part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginPhoneInit extends LoginState {}

class LoginPhoneError extends LoginState {
  final AppBaseResponse res;

  LoginPhoneError(this.res);
}

class LoginPhoneSuccess extends LoginState {
  final LoginResponseModel res;

  LoginPhoneSuccess(this.res);
}

class LoginVerifyCodeInit extends LoginState {}

class LoginVerifyCodeError extends LoginState {
  final AppBaseResponse res;

  LoginVerifyCodeError(this.res);
}

class LoginVerifyCodeSuccess extends LoginState {
  final VerificationResponse res;

  LoginVerifyCodeSuccess(this.res);
}
