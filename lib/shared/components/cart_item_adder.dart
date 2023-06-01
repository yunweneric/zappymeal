import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

Container cartAdderAndRemover({
  required BuildContext context,
  required VoidCallback onAdd,
  required String quantity,
  required VoidCallback onRemove,
  required double width,
  required EdgeInsetsGeometry itemPadding,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: radiusSm(),
      border: Border.all(color: Theme.of(context).primaryColorDark.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        InkWell(onTap: onAdd, child: Container(padding: itemPadding, child: Icon(Icons.add, size: 15.r))),
        Container(
          padding: kpadding(10.w, 5.w),
          child: Text(quantity, style: TextStyle(color: Theme.of(context).primaryColor)),
          decoration: BoxDecoration(
            border: Border.symmetric(vertical: BorderSide(color: Theme.of(context).highlightColor)),
            color: Theme.of(context).highlightColor,
          ),
        ),
        InkWell(onTap: onRemove, child: Container(padding: itemPadding, child: Icon(Icons.remove, size: 15.r))),
      ],
    ),
  );
}
