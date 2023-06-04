part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginPhoneInit extends LoginState {}

class LoginPhoneError extends LoginState {
  final BaseResponse res;

  LoginPhoneError(this.res);
}

class LoginPhoneSuccess extends LoginState {
  final LoginResponseModel res;

  LoginPhoneSuccess(this.res);
}
