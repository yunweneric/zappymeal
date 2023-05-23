import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showErrorAlert({required BuildContext context, required String title, required String desc, VoidCallback? onOkay, VoidCallback? onCancel, bool? isError, bool? animate}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    title: title.tr(),
    desc: desc.tr(),
    btnOkText: "global.okay".tr(),
    btnCancelText: "global.cancel".tr(),
    titleTextStyle: Theme.of(context).textTheme.headline4,
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

showWarningAlert({
  required BuildContext context,
  required String title,
  required String desc,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: title.tr(),
    desc: desc.tr(),
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    btnOkOnPress: () {},
  )..show();
}
