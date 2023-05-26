import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

Widget cartItem({
  required BuildContext context,
  required AddMealReqModel meal,
  required void Function(BuildContext)? onDelete,
  required VoidCallback onAdd,
  required VoidCallback onRemove,
}) {
  return Slidable(
    endActionPane: ActionPane(
      motion: ScrollMotion(),
      children: [
        Container(
          width: 80.w,
          margin: kph(20.w),
          child: SlidableAction(
            borderRadius: radiusM(),
            onPressed: onDelete,
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline_rounded,
          ),
        ),
      ],
    ),
    child: Container(
      child: Row(
        children: [
          coverImage(context: context, height: 60.w, width: 70.w, borderRadius: 10.r, url: meal.imageUrl),
          kwSpacer(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meal.name, style: Theme.of(context).textTheme.displaySmall, maxLines: 2),
                khSpacer(5.h),
                Text(
                  Formaters.formatCurrency(meal.price) + " " + meal.restaurant.country.currencyCode,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          kwSpacer(10.w),
          Container(
            // padding: kpadding(10.w, 0),
            decoration: BoxDecoration(
              borderRadius: radiusSm(),
              border: Border.all(
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                InkWell(onTap: onAdd, child: Container(padding: kpadding(5.w, 7.w), child: Icon(Icons.add, size: 15.r))),
                Container(
                  padding: kpadding(10.w, 5.w),
                  child: Text(meal.quantity.toString(), style: TextStyle(color: Theme.of(context).primaryColor)),
                  decoration: BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide(color: Theme.of(context).highlightColor)),
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                InkWell(onTap: onRemove, child: Container(padding: kpadding(5.w, 7.w), child: Icon(Icons.remove, size: 15.r))),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
