import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/login/login_res_model.dart';
import 'package:zappy_meal/models/login/verification_res_model.dart';
import 'package:zappy_meal/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository authRepository = AuthRepository();
  LoginCubit() : super(LoginInitial());

  void phoneLogin(BuildContext context, String phoneNumber) async {
    emit(LoginPhoneInit());
    try {
      AppBaseReponse res = await authRepository.phoneLogin(context, phoneNumber);
      res.statusCode == 200 ? emit(LoginPhoneSuccess(LoginResponseModel.fromJson(res.data))) : emit(LoginPhoneError(res));
    } catch (e) {
      emit(LoginPhoneError(authRepository.auth_service.apiServerError()));
    }
  }

  verifyCode(BuildContext context, String otpCode) async {
    emit(LoginVerifyCodeInit());
    try {
      AppBaseReponse res = await authRepository.verifyCode(context, otpCode);
      res.statusCode == 200 ? emit(LoginVerifyCodeSuccess(VerificationResponse.fromJson(res.data))) : emit(LoginVerifyCodeError(res));
    } catch (e) {
      emit(LoginVerifyCodeError(authRepository.auth_service.apiServerError()));
    }
  }
}
