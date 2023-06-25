import 'package:flutter/material.dart';
import 'package:zappy_meal/mock/user_service.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/shared/utils/local_storage.dart';

class UserRepository with LocalPrefs {
  MockUserService _userService = MockUserService();
  AppBaseResponse apiServerError() => _userService.apiServerError();

  Future<AppBaseResponse> repFindUserData(BuildContext context) async {
    return _userService.findCurrentUserData();
  }

  Future<AppBaseResponse> fetchAllUsers(BuildContext context) {
    return _userService.getAllUsers(context);
  }

  Future<AppBaseResponse> updateProfilePicture(BuildContext context, String profileImage) {
    return _userService.updateProfilePicture(profileImage);
  }
}
