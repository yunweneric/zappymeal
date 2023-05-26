import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Widget appBarBackButton({required BuildContext context, required Widget icon, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap ?? () => context.pop(),
    child: Container(
      width: 20.w,
      height: 20.w,
      margin: EdgeInsets.only(left: 10.w),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        radius: 28.r,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // radius: 20.r,
          child: icon,
        ),
      ),
    ),
  );
}
