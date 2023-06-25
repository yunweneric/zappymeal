import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/controllers/user/user_cubit.dart';
import 'package:zappy_meal/models/user/user_model.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/screens/users/widget.dart';
import 'package:zappy_meal/shared/components/avatar_circle.dart';
import 'package:zappy_meal/shared/components/modals.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shadow.dart';
import 'package:zappy_meal/shared/components/shimmers.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/helpers/image_helpers.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/local_storage.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class ProfileScreen extends StatefulWidget {
  final bool query;
  const ProfileScreen({super.key, required this.query});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppUser? user;
  bool loading = true;
  bool error = false;

  @override
  void initState() {
    context.read<UserCubit>().fetchUserData(context);
    super.initState();
  }

  Future<void> pickImage() async {
    File? file = await ImageHelper.takeImage();
    if (file != null) {
      context.read<UserCubit>().updateProfilePicture(context, file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.query
          ? AppBar(
              automaticallyImplyLeading: true,
              leadingWidth: 50.w,
              leading: GestureDetector(onTap: () => context.pop(), child: Icon(Icons.arrow_back)),
              title: Text("Profile"),
            )
          : AppBar(automaticallyImplyLeading: false),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserFetchDataSuccess) Future.delayed(1200.ms, () => setState(() => loading = false));

          //Todo:: When alert are all up implement this.
          if (state is UserFetchDataError) {}
          if (state is UserUpdateProfilePictureSuccess) {
            context.read<UserCubit>().fetchUserData(context);
          }
        },
        builder: (context, state) {
          if (state is UserFetchDataInit) loading = true;
          if (state is UserFetchDataError) loading = true;
          if (state is UserFetchDataSuccess) {
            user = state.user;
          }
          if (state is UserUpdateProfilePictureInit) loading = true;
          if (state is UserUpdateProfilePictureError) loading = true;
          // if (state is UserUpdateProfilePictureError) loading = false;

          return SingleChildScrollView(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: loading
                  ? Column(children: AppShimmers.profileScreenShimmer(context))
                  : Column(
                      children: AnimateList(
                        interval: 100.ms,
                        effects: [ScaleEffect(), FadeEffect()],
                        delay: 400.ms,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: avatarCircle(context: context, radius: 60.r, image: user?.photoUrl),
                          ),
                          kh20Spacer(),
                          Container(
                            padding: kpadding(10.w, 5.h),
                            margin: kAppPading(),
                            decoration: BoxDecoration(
                              boxShadow: appShadow(context),
                              color: Theme.of(context).cardColor,
                              borderRadius: radiusSm(),
                            ),
                            child: profileInfo(
                              context: context,
                              title: "Change Profile Photo",
                              value: user!.role.role,
                              icon: AppIcons.camera,
                              scale: 0.7,
                              showDivider: false,
                              onTap: () => pickImage(),
                            ),
                          ),
                          kh20Spacer(),
                          Container(
                            padding: kpadding(10.w, 10.h),
                            margin: kAppPading(),
                            decoration: BoxDecoration(
                              boxShadow: appShadow(context),
                              color: Theme.of(context).cardColor,
                              borderRadius: radiusSm(),
                            ),
                            child: Column(
                              children: [
                                profileInfo(context: context, title: "Name", value: user?.username ?? "----", icon: AppIcons.user, scale: 0.8),
                                profileInfo(context: context, title: "Phone", value: user?.phoneNumber ?? "----", icon: AppIcons.phone, scale: 0.8),
                                profileInfo(context: context, title: "Role", value: user?.role.role ?? "----", icon: AppIcons.user, scale: 0.8),
                                profileInfo(
                                  context: context,
                                  title: "Date of birth",
                                  value: Formaters.formatDate(user?.date_of_birth),
                                  icon: AppIcons.calendar,
                                  scale: 0.6,
                                  showDivider: false,
                                ),
                              ],
                            ),
                          ),
                          kh20Spacer(),
                          Container(
                            padding: kpadding(10.w, 10.h),
                            margin: kAppPading(),
                            decoration: BoxDecoration(
                              boxShadow: appShadow(context),
                              color: Theme.of(context).cardColor,
                              borderRadius: radiusSm(),
                            ),
                            child: Column(
                              children: [
                                profileInfo(context: context, title: "Reset Account", value: "", icon: AppIcons.user, scale: 0.8),
                                profileInfo(
                                  onTap: () => AppModal.showInfoAlert(
                                    context: context,
                                    desc: "Are you sure you want to logout?",
                                    title: "Log out!",
                                    onCancel: () {},
                                    btnOkOnPress: () async {
                                      await LocalPrefs.logOutUser();
                                      context.go(AppRoutes.splash);
                                    },
                                  ),
                                  context: context,
                                  title: "Logout",
                                  value: "",
                                  icon: AppIcons.lock,
                                  scale: 0.6,
                                  showDivider: false,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
