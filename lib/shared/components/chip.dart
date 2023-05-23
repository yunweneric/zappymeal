import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

Widget chip({
  required BuildContext context,
  required String title,
  required VoidCallback onTap,
  required String icon,
  Color? color,
  EdgeInsetsGeometry? padding,
}) {
  return Chip(
    padding: padding ?? kpadding(8.w, 10.h),
    backgroundColor: color,
    label: Row(
      children: [
        SvgPicture.asset(icon, width: 15.w),
        kwSpacer(5.w),
        Text(title, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.sp)),
      ],
    ),
  );
}
