import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shadow.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AppShimmers {
  static AnimateList<Widget> profileScreenShimmer(BuildContext context) {
    return AnimateList(
      interval: 100.ms,
      effects: [ScaleEffect(), FadeEffect()],
      delay: 400.ms,
      children: [
        Align(
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).highlightColor.withOpacity(0.5),
            highlightColor: Theme.of(context).primaryColorLight,
            child: CircleAvatar(radius: 60.r, backgroundColor: Theme.of(context).primaryColor),
          ),
        ),
        kh20Spacer(),
        Container(
          padding: kpadding(10.w, 5.h),
          margin: kAppPading(),
          decoration: BoxDecoration(
            boxShadow: appShadow(context),
            color: Theme.of(context).cardColor,
            borderRadius: radiusSm(),
          ),
          child: profileInfoShimmer(
            context: context,
            scale: 0.7,
            showDivider: false,
          ),
        ),
        kh20Spacer(),
        Container(
          padding: kpadding(10.w, 10.h),
          margin: kAppPading(),
          decoration: BoxDecoration(
            boxShadow: appShadow(context),
            color: Theme.of(context).cardColor,
            borderRadius: radiusSm(),
          ),
          child: Column(
            children: List.generate(3, (index) => profileInfoShimmer(context: context)),
          ),
        ),
        kh20Spacer(),
        Container(
          padding: kpadding(10.w, 10.h),
          margin: kAppPading(),
          decoration: BoxDecoration(
            boxShadow: appShadow(context),
            color: Theme.of(context).cardColor,
            borderRadius: radiusSm(),
          ),
          child: Column(
            children: List.generate(2, (index) => profileInfoShimmer(context: context)),
          ),
        )
      ],
    );
  }

  static Widget gridRestaurantShimmer(int length, BuildContext context, bool canScroll) {
    return AnimationLimiter(
      child: GridView.builder(
        // padding: kpadding(0, 5.h),
        shrinkWrap: canScroll ? false : true,
        physics: canScroll ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.w,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        itemCount: length,
        itemBuilder: (BuildContext ctx, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: ScaleAnimation(child: FadeInAnimation(child: restaurantShimmer(context, index))),
          );
        },
      ),
    );
  }

  static Widget profileInfoShimmer({required BuildContext context, double scale = 1, bool showDivider = true}) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).highlightColor.withOpacity(0.5),
      highlightColor: Theme.of(context).primaryColorLight,
      child: Column(
        children: [
          Container(
            width: kwidth(context),
            margin: kpadding(5.h, 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5.r)),
                  child: Transform.scale(
                    scale: scale,
                    child: SizedBox(),
                  ),
                ),
                kwSpacer(10.w),
                Container(width: 150.w, height: 3.h, color: Colors.red),
                Spacer(),
                Container(width: 30.w, height: 3.h, color: Colors.red),
              ],
            ),
          ),
          if (showDivider) Divider()
        ],
      ),
    );
  }

  static Widget profileCounterShimmer({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: appShadow(context), borderRadius: radiusSm()),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).highlightColor.withOpacity(0.5),
        highlightColor: Theme.of(context).primaryColorLight,
        child: Container(
          padding: kpadding(0.w, 25.h),
          width: kwidth(context) / 3.6,
          child: Column(
            children: [
              khSpacer(20.h),
              Container(width: 30.w, height: 2.h, color: Colors.red),
              khSpacer(10.h),
              Container(width: 30.w, height: 2.h, color: Colors.red),
              khSpacer(20.h),
            ],
          ),
        ),
      ),
    );
  }

  static Widget restaurantListShimmer(int length, BuildContext context, bool canScroll, bool isVertical) {
    return ListView.builder(
        itemCount: length,
        shrinkWrap: canScroll ? true : false,
        physics: canScroll ? null : NeverScrollableScrollPhysics(),
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: isVertical ? 160.h : 100.h,
            margin: isVertical ? EdgeInsets.only(bottom: 10.h) : EdgeInsets.only(left: 10.w),
            width: 150.w,
            child: AppShimmers.restaurantShimmer(context, index),
          );
        });
  }

  static Widget restaurantList2Shimmer(int length, BuildContext context, bool canScroll, bool isVertical) {
    return ListView.builder(
        itemCount: length,
        shrinkWrap: canScroll ? false : true,
        physics: canScroll ? null : NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: AppShimmers.restaurantCardShimmer(context, index),
          );
        });
  }

  static Widget restaurantShimmer(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).scaffoldBackgroundColor,
        highlightColor: Theme.of(context).cardColor,
        enabled: true,
        child: AnimationLimiter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 90.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            kh10Spacer(),
                            kh10Spacer(),
                            shimmerDivider(context),
                            kh10Spacer(),
                            shimmerDivider(context),
                            kh10Spacer(),
                            shimmerDivider(context),
                            kh10Spacer(),
                            shimmerDivider(context),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            itemCount: 6,
          ),
        ),
      ),
    );
  }

  static Widget restaurantCardShimmer(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).scaffoldBackgroundColor,
        highlightColor: Theme.of(context).cardColor,
        enabled: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 90.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Theme.of(context).cardColor,
              ),
            ),
            kwSpacer(15.w),
            Expanded(
              child: Column(
                children: <Widget>[
                  shimmerDivider(context),
                  kh10Spacer(),
                  shimmerDivider(context),
                  kh10Spacer(),
                  shimmerDivider(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Container shimmerDivider(context) {
    return Container(
      width: double.infinity,
      height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
