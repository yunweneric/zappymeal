import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uuid/uuid.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/login/login_res_model.dart';
import 'package:zappy_meal/models/login/verification_res_model.dart';
import 'package:zappy_meal/services/base_service.dart';

import '../models/user/user_roles.dart';

class AuthService extends BaseService {
  Faker faker = new Faker();
  Future<AppBaseResponse> phoneLogin(BuildContext context, String phoneNumber) async {
    // return basePost(data: {'phone': phoneNumber}, urlPath: "", isSimpleHeaders: true);
    // return apiSuccess(message: "Login successful!", data: {});

    LoginResponseModel res = LoginResponseModel(
      id: Uuid().v1(),
      name: faker.person.firstName(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      code: faker.randomGenerator.numberOfLength(4),
    );
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "verification successful", data: res.toJson());
  }

  Future<AppBaseResponse> verifyCode(BuildContext context, String otpCode) async {
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
    VerificationResponse res = VerificationResponse(
      id: Uuid().v1(),
      name: faker.person.firstName(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      imageUrl: "https://randomuser.me/api/portraits/women/${Random().nextInt(100)}.jpg",
      token: faker.jwt.secret,
      role: UserRole(id: Uuid().v1(), name: role),
    );
    await Future.delayed(3000.ms, () {});

    return apiSuccess(message: "verification successful", data: res.toJson());
    // return basePost(data: {'code': otpCode}, urlPath: "", isSimpleHeaders: true);
  }
}
