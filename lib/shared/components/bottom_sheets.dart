import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zappy_meal/shared/utils/index.dart';

class AppBottomSheet {
  static baseBottomSheet({required BuildContext context, required Widget child}) {
    return showBarModalBottomSheet(
      backgroundColor: Theme.of(context).cardColor,
      context: context,
      builder: (context) => child,
    );
  }

  static simpleSheet({
    required BuildContext context,
    required double height,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    AlignmentGeometry? alignment,
  }) {
    return baseBottomSheet(
      context: context,
      child: Stack(
        children: [
          Container(
            child: child,
            alignment: alignment,
            height: height,
            padding: padding,
            margin: margin,
            decoration: decoration,
          ),
          Positioned(
            right: 20,
            top: 20,
            child: GestureDetector(onTap: () => context.pop(), child: SvgPicture.asset(AppIcons.close_square, width: 30.w)),
          )
        ],
      ),
    );
  }
}
