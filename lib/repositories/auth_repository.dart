import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/services/auth_service.dart';

class AuthRepository {
  AuthService auth_service = AuthService();

  Future<AppBaseReponse> phoneLogin(BuildContext context, String phoneNumber) {
    return auth_service.phoneLogin(context, phoneNumber);
  }

  Future<AppBaseReponse> verifyCode(BuildContext context, String otpCode) {
    return auth_service.verifyCode(context, otpCode);
  }
}
