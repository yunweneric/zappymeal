import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppBottomSheet {
  static Future<Widget> baseBottomSheet({required BuildContext context, required Widget child}) async {
    return await showBarModalBottomSheet(
      backgroundColor: Theme.of(context).cardColor,
      context: context,
      builder: (context) => child,
    );
  }

  static Future<Widget> simpleSheet({
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
      child: Container(
        child: child,
        alignment: alignment,
        height: height,
        padding: padding,
        margin: margin,
        decoration: decoration,
      ),
    );
  }
}
