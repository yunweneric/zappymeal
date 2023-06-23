import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/shared/components/avatar_circle.dart';
import 'package:zappy_meal/shared/components/bottom_sheets.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/utils/local_storage.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Center(child: avatarCircle(context: context, radius: 50.r)),
              kh20Spacer(),
              submitButton(
                width: 300.w,
                context: context,
                onPressed: () => AppBottomSheet.simpleSheet(
                  alignment: Alignment.center,
                  context: context,
                  height: 300.h,
                  padding: kpadding(20.w, 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Are you sure you want to log out?", style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
                      kh20Spacer(),
                      submitButton(
                        width: 200.w,
                        context: context,
                        onPressed: () async {
                          await LocalPrefs.saveToken("");
                          context.go(AppRoutes.splash);
                        },
                        text: "Yes",
                      ),
                      kh10Spacer(),
                      submitButton(
                        width: 200.w,
                        context: context,
                        onPressed: () {},
                        text: "No",
                      )
                    ],
                  ),
                ),
                text: "Logout",
              )
            ],
          ),
        ),
      ),
    );
  }
}
