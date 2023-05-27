import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

showErrorAlert({required BuildContext context, required String title, required String desc, VoidCallback? onOkay, VoidCallback? onCancel, bool? isError, bool? animate}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    title: title.tr(),
    desc: desc.tr(),
    btnOkText: "global.okay".tr(),
    btnCancelText: "global.cancel".tr(),
    titleTextStyle: Theme.of(context).textTheme.headlineMedium,
    descTextStyle: Theme.of(context).textTheme.bodySmall,
    btnCancelOnPress: onCancel,
    padding: animate == true ? EdgeInsets.symmetric(horizontal: 20.w) : EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
    btnOkOnPress: onOkay,
  )..show();
}

showInfoAlert({
  required BuildContext context,
  required String title,
  required String desc,
  required VoidCallback btnOkOnPress,
  VoidCallback? onCancel,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    animType: AnimType.scale,
    title: title.tr(),
    desc: desc.tr(),
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: onCancel,
  )..show();
}

showSuccessAlert({
  required BuildContext context,
  required String title,
  required String description,
  bool dismissOnTouchOutside = true,
  bool dismissOnBackKeyPress = true,
}) {
  return AwesomeDialog(
    context: context,
    dismissOnTouchOutside: dismissOnTouchOutside,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    dialogType: DialogType.noHeader,
    animType: AnimType.scale,
    body: Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                SvgPicture.asset(SvgAssets.success_confetti),
                kh10Spacer(),
                Text(title, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
                kh10Spacer(),
                Text(description, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                kh20Spacer()
              ],
            ),
          ),
        ],
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
  )..show();
}
