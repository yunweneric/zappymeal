import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/user/user_model.dart';
import 'package:zappy_meal/repositories/user_repository.dart';
import 'package:zappy_meal/shared/utils/logger_util.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepo = UserRepository();
  UserCubit() : super(UserInitial());

  void fetchUserData(BuildContext context) async {
    try {
      emit(UserFetchDataInit());
      AppBaseResponse res = await _userRepo.repFindUserData(context);
      res.statusCode == 200 ? emit(UserFetchDataSuccess(AppUser.fromJson(res.data))) : emit(UserFetchDataError(res));
    } catch (e) {
      logI(["User cubit fetchUserData ", e]);
      emit(UserFetchDataError(_userRepo.apiServerError()));
    }
  }

  void fetchAllUsers(BuildContext context) async {
    try {
      emit(UserFetchAllUsersInit());
      AppBaseResponse res = await _userRepo.fetchAllUsers(context);
      res.statusCode == 200 ? emit(UserFetchAllUsersSuccess(res)) : emit(UserFetchAllUsersError(res));
    } catch (e) {
      logI(["User cubit fetchUserData ", e]);
      emit(UserFetchAllUsersError(_userRepo.apiServerError()));
    }
  }

  void updateProfilePicture(BuildContext context, String profileImage) async {
    try {
      emit(UserUpdateProfilePictureInit());
      AppBaseResponse res = await _userRepo.updateProfilePicture(context, profileImage);
      res.statusCode == 200 ? emit(UserUpdateProfilePictureSuccess(res)) : emit(UserUpdateProfilePictureError(res));
    } catch (e) {
      logI(["User cubit updateProfilePicture ", e]);
      emit(UserUpdateProfilePictureError(_userRepo.apiServerError()));
    }
  }
}
