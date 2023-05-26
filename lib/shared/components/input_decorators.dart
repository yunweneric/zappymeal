import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

InputDecoration phoneInputDecorator({required BuildContext context, required String hint}) {
  return InputDecoration(
    contentPadding: kpadding(20.w, 10.h),
    prefixIconConstraints: BoxConstraints(minHeight: 50.w, minWidth: 50.w),
    hintText: hint,
    prefixIcon: Transform.scale(
      scale: 0.6,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: radiusSm()),
        child: Transform.scale(scale: 0.5, child: SvgPicture.asset(AppIcons.phone, width: 3.w, height: 2.w)),
      ),
    ),
  );
}
