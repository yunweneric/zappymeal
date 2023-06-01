import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zappy_meal/shared/components/appbar_back_btn.dart';
import 'package:zappy_meal/shared/components/chip.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/filter_icon.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class RestaurantListingScreen extends StatefulWidget {
  const RestaurantListingScreen({super.key});

  @override
  State<RestaurantListingScreen> createState() => _RestaurantListingScreenState();
}

class _RestaurantListingScreenState extends State<RestaurantListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appBarBackButton(context: context, icon: Icon(Icons.arrow_back)),
        title: Text("Restaurant", style: Theme.of(context).textTheme.displayMedium),
        actions: [
          filterIcon(context),
          kwSpacer(10.w),
        ],
        toolbarHeight: 80.h,
      ),
      body: Container(
        height: kheight(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // kh20Spacer(),
              Padding(
                padding: kAppPading(),
                child: Row(
                  children: [
                    chip(context: context, title: "Nearby", onTap: () {}, icon: AppIcons.check, color: Theme.of(context).primaryColor),
                    kwSpacer(10.w),
                    chip(context: context, title: "Popular", onTap: () {}, icon: AppIcons.dot, color: Theme.of(context).highlightColor),
                  ],
                ),
              ),
              kh10Spacer(),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return FadeIn(
                    delay: 150.ms * index,
                    child: SlideInUp(
                      from: 300.h,
                      delay: 150.ms * index,
                      child: restaurantCard(context),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(endIndent: 20.w, indent: 20.w),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container restaurantCard(BuildContext context) {
    return Container(
      margin: kAppPading(),
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
                child: coverImage(context: context, height: 80.h, width: 100.w),
              ),
            ],
          ),
          kwSpacer(10.w),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: kpadding(10.w, 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Container(
                          width: 85.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          padding: kpadding(5.w, 5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppIcons.send_envelop),
                              kwSpacer(5.w),
                              Text("Less Than 500 m", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 7.sp)),
                            ],
                          ),
                        ),
                      ),
                      khSpacer(2.h),
                      Text("Restaurant H", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor)),
                      khSpacer(5.h),
                      Row(
                        children: List.generate(
                          4,
                          (index) => SvgPicture.asset(AppIcons.star, width: 15.w),
                        ),
                      ),
                      khSpacer(5.h),
                      SizedBox(
                        width: kwidth(context) * 0.4,
                        child: Text(
                          "Douala Denver, Makepe Denv",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
