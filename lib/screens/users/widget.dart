import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shadow.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

Widget profileInfo({
  required String title,
  required String value,
  required String icon,
  required BuildContext context,
  double scale = 1,
  bool showDivider = true,
  VoidCallback? onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: kwidth(context),
            margin: kpadding(5.h, 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.r)),
                  child: Transform.scale(
                    scale: scale,
                    child: SvgPicture.asset(icon, color: Theme.of(context).primaryColorLight),
                  ),
                ),
                kwSpacer(10.w),
                Text(title),
                Spacer(),
                Text(value),
              ],
            ),
          ),
          if (showDivider) Divider()
        ],
      ),
    );

Container profileCounter({required BuildContext context, required String title, required String count}) {
  return Container(
    padding: kpadding(0.w, 25.h),
    width: kwidth(context) / 3.6,
    decoration: BoxDecoration(
      color: title != "Points" ? Theme.of(context).cardColor.withOpacity(1) : Theme.of(context).primaryColor,
      boxShadow: appShadow(context),
      borderRadius: radiusSm(),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: title == "Points" ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor),
        ),
        khSpacer(10.h),
        Text(
          count,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 20.sp, color: title == "Points" ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor),
        ),
      ],
    ),
  );
}
