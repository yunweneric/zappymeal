import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/user/user_model.dart';
import 'package:zappy_meal/services/base_service.dart';

class MockUserService extends BaseService {
  Future<AppBaseResponse> updateProfilePicture(String profileImage) async {
    await Future.delayed(3000.ms);
    return apiSuccess(message: "", data: {});
  }

  Future<AppBaseResponse> getAllUsers(BuildContext context) async {
    await Future.delayed(3000.ms);
    return apiSuccess(message: "", data: {});
  }

  Future<AppBaseResponse> findCurrentUserData() async {
    await Future.delayed(3000.ms);
    AppUser user = MockData.user;
    return apiSuccess(message: "", data: user.toJson());
  }
}
