import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AppShimmers {
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
              height: 90.h,
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
