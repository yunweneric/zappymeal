import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy_meal/shared/components/bottom_sheets.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/chip.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/icons_assets.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:zappy_meal/theme/colors.dart';

RangeValues price_range = RangeValues(1500, 5000);
int min_price_range = 500;
int max_price_range = 5000;
bool apply_restaurant_filter = false;
bool apply_date_field = false;
bool _isFocused = false;
String query = "";
FocusNode _search_input_node = FocusNode();
bool loading = false;
bool error = false;
Widget filterIcon(BuildContext context) {
  return GestureDetector(
    onTap: () {
      AppBottomSheet.simpleSheet(
        context: context,
        height: kheight(context),
        padding: kpadding(20.w, 30.h),
        child: StatefulBuilder(builder: (context, setNewState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Text("Filters", style: Theme.of(context).textTheme.displayMedium),
                kh20Spacer(),
                distanceSlider(context, setNewState),
                restaurantType(context),
                restaurantVeg(context),
                discountRestaurant(context),
                filterRestaurantByRating(context),
                kh10Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    submitButton(
                      width: kwidth(context) / 2.5,
                      context: context,
                      onPressed: () {},
                      text: "Cancel",
                      color: Theme.of(context).cardColor,
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      textColor: Theme.of(context).primaryColor,
                    ),
                    submitButton(
                      context: context,
                      onPressed: () {},
                      text: "Apply",
                      width: kwidth(context) / 2.5,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      );
    },
    child: CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 20.r,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        radius: 18.r,
        child: SvgPicture.asset(AppIcons.filter),
      ),
    ),
  );
}

Widget distanceSlider(BuildContext context, StateSetter setNewState) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Distance from the restaurant"),
      SliderTheme(
        data: SliderThemeData(
          showValueIndicator: ShowValueIndicator.onlyForDiscrete,
          trackHeight: 2.h,
          rangeTrackShape: RectangularRangeSliderTrackShape(),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 18.r),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
          rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 12.r),
          trackShape: RoundedRectSliderTrackShape(),
          valueIndicatorColor: Theme.of(context).primaryColor,
          valueIndicatorTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: kWhite, fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
        child: RangeSlider(
          labels: RangeLabels(Formaters.formatCurrency(price_range.start.toInt().toString()), Formaters.formatCurrency(price_range.end.toInt().toString())),
          min: 500,
          max: 5000,
          divisions: 9,
          values: price_range,
          onChanged: (val) => setNewState(() => price_range = val),
        ),
      ),
      kh10Spacer(),
      Divider()
    ],
  );
}

Widget restaurantVeg(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      khSpacer(10.h),
      Text("Is the Restaurant is Veg?"),
      khSpacer(10.h),
      Row(
        children: [
          chip(
            context: context,
            title: "Yes",
            onTap: () {},
            icon: AppIcons.check,
            color: Theme.of(context).primaryColor,
          ),
          kwSpacer(10.w),
          chip(context: context, title: "No", onTap: () {}, icon: AppIcons.dot),
        ],
      ),
      kh10Spacer(),
      Divider()
    ],
  );
}

Widget discountRestaurant(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      khSpacer(10.h),
      Text("Does the Restaurant have a discount?"),
      khSpacer(10.h),
      Row(
        children: [
          chip(
            context: context,
            title: "Yes",
            onTap: () {},
            icon: AppIcons.check,
            color: Theme.of(context).primaryColor,
          ),
          kwSpacer(10.w),
          chip(context: context, title: "No", onTap: () {}, icon: AppIcons.dot),
        ],
      ),
      kh10Spacer(),
      Divider()
    ],
  );
}

Widget filterRestaurantByRating(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      khSpacer(10.h),
      Text("Filter By Rating"),
      khSpacer(10.h),
      Row(
        children: List.generate(
          4,
          (index) => Row(
            children: [
              chip(
                context: context,
                title: "${index + 1}",
                onTap: () {},
                icon: AppIcons.star,
                padding: kpadding(8.w, 10.h),
                color: Theme.of(context).primaryColor,
              ),
              kwSpacer(10.w),
            ],
          ),
        ),
      ),
      kh10Spacer(),
      Divider()
    ],
  );
}

Widget restaurantType(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      kh10Spacer(),
      Text("Type of Restaurant"),
      khSpacer(10.h),
      Row(
        children: [
          chip(context: context, title: "Type 1", onTap: () {}, icon: AppIcons.dot),
          kwSpacer(10.w),
          chip(
            context: context,
            title: "Type 1",
            onTap: () {},
            icon: AppIcons.check,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      kh10Spacer(),
      Divider(),
    ],
  );
}
