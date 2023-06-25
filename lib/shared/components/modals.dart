import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zappy_meal/shared/utils/animations_assets.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class AppModal {
  static showBaseAlert({required BuildContext context, required Widget body}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: body,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
    )..show();
  }

  static showErrorAlert({required BuildContext context, required String title, required String desc, VoidCallback? onOkay, VoidCallback? onCancel, bool? isError, bool? animate}) {
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

  static showInfoAlert({
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

  static showWarningAlert({
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

  static showSuccessAlert({required BuildContext context, required String message}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Container(
        padding: kpadding(10.w, 40.h),
        child: Column(
          children: [
            Lottie.asset(AnimationAsset.success, height: 150.h, width: 200.w),
            kh10Spacer(),
            Text(
              message,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).primaryColor, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
    )..show();
  }
}
