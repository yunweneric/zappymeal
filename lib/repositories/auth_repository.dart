import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/mock/auth_service.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

class AuthRepository {
  MockAuthService auth_service = MockAuthService();

  Future<AppBaseResponse> phoneLogin(BuildContext context, String phoneNumber) {
    return auth_service.phoneLogin(context, phoneNumber);
  }

  Future<AppBaseResponse> verifyCode(BuildContext context, String otpCode) {
    return auth_service.verifyCode(context, otpCode);
  }
}
