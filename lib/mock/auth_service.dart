import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uuid/uuid.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/login/login_res_model.dart';
import 'package:zappy_meal/models/login/verification_res_model.dart';
import 'package:zappy_meal/services/base_service.dart';

import '../models/user/user_roles.dart';

class MockAuthService extends BaseService {
  Faker faker = new Faker();
  Future<AppBaseReponse> phoneLogin(BuildContext context, String phoneNumber) async {
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "verification successful", data: MockData.loginData.toJson());
  }

  Future<AppBaseReponse> verifyCode(BuildContext context, String otpCode) async {
    String role = AppRoles.admin;
    switch (otpCode) {
      case "0000":
        role = AppRoles.admin;
        break;
      case "1111":
        role = AppRoles.user;
        break;
      case "2222":
        role = AppRoles.dispatcher;
        break;
      case "3333":
        role = AppRoles.restaurantAdmin;
        break;
      default:
    }
    await Future.delayed(3000.ms, () {});

    return apiSuccess(message: "verification successful", data: MockData.verificationData(role).toJson());
  }
}
