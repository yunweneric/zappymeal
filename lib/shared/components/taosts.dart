import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:zappy_meal/theme/colors.dart';

showToastSuccess(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: kWhite,
    textColor: primaryColor,
    fontSize: 12.w,
  );
}

showToastSuccess2(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: kWhite,
    textColor: kWhite,
    fontSize: 12.w,
  );
}

showToastSuccess3(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: kWhite,
    textColor: kWhite,
    fontSize: 12.w,
  );
}

showToastInfo(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: kWhite,
    textColor: primaryColor,
    fontSize: 16.0,
  );
}

showToastError(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 12.0.sp,
  );
}

showMealToast({required AddMealReqModel meal, required BuildContext context}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 20,
    backgroundColor: (Theme.of(context).cardColor),
    padding: kpadding(5.w, 15.h),
    margin: kph(20.w),
    shape: RoundedRectangleBorder(borderRadius: radiusM()),
    content: ListTile(
      shape: RoundedRectangleBorder(borderRadius: radiusM()),
      leading: coverImage(context: context, height: 80.h, width: 60.w, borderRadius: 10.r),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(meal.name, style: Theme.of(context).textTheme.displaySmall),
          khSpacer(2.h),
          Text("Added to cart", style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      trailing: GestureDetector(
        onTap: () => context.push(AppRoutes.checkout),
        child: Text(
          "View Card",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor),
        ),
      ),
    ),
  );
}
