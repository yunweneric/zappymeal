import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/services/base_service.dart';

class AuthService extends BaseService {
  Future<AppBaseReponse> phoneLogin(BuildContext context, String phoneNumber) async {
    return basePost(data: {'phone': phoneNumber}, urlPath: "", isSimpleHeaders: true);
  }

  Future<AppBaseReponse> verifyCode(BuildContext context, String otpCode) async {
    return basePost(data: {'code': otpCode}, urlPath: "", isSimpleHeaders: true);
  }
}
