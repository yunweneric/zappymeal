part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserFetchDataInit extends UserState {}

class UserFetchDataError extends UserState {
  final AppBaseResponse res;
  UserFetchDataError(this.res);
}

class UserFetchDataSuccess extends UserState {
  final AppUser user;
  UserFetchDataSuccess(this.user);
}

class UserFetchAllUsersInit extends UserState {}

class UserFetchAllUsersError extends UserState {
  final AppBaseResponse res;
  UserFetchAllUsersError(this.res);
}

class UserFetchAllUsersSuccess extends UserState {
  final AppBaseResponse users;
  UserFetchAllUsersSuccess(this.users);
}

class UserAddSoulAndUpdateRefererInit extends UserState {}

class UserAddSoulAndUpdateRefererError extends UserState {
  final AppBaseResponse res;
  UserAddSoulAndUpdateRefererError(this.res);
}

class UserAddSoulAndUpdateRefererSuccess extends UserState {
  final AppBaseResponse users;
  UserAddSoulAndUpdateRefererSuccess(this.users);
}

class UserUpdateProfilePictureInit extends UserState {}

class UserUpdateProfilePictureError extends UserState {
  final AppBaseResponse res;
  UserUpdateProfilePictureError(this.res);
}

class UserUpdateProfilePictureSuccess extends UserState {
  final AppBaseResponse res;
  UserUpdateProfilePictureSuccess(this.res);
}
