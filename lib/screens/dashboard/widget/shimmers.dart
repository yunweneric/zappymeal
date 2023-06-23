import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zappy_meal/models/counter/counter_model.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

Container superAdminGridCards(List<CounterModel> counter, BuildContext context) {
  return Container(
    child: GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.w,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 20.w,
      ),
      itemCount: counter.length,
      itemBuilder: (BuildContext ctx, index) {
        return InkWell(
          onTap: () {
            switch (index) {
              case 0:
                // Navigator.pushNamed(context, AppRoutes.viewRestaurantsScreen);

                break;
              case 1:
                // Navigator.pushNamed(context, AppRoutes.viewMealsScreen);
                break;
              case 2:
                // Navigator.pushNamed(context, AppRoutes.listCategoryScreen);
                break;
              case 3:
                break;
            }
          },
          child: Container(
            width: kwidth(context),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(offset: Offset(0, 0), color: Theme.of(context).shadowColor.withOpacity(0.3), blurRadius: 5.r),
              ],
              borderRadius: BorderRadius.circular(20.r),
              color: Theme.of(context).cardColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    right: -50,
                    child: Container(
                      height: 100.h,
                      child: Image.asset('assets/images/blob.png', color: Theme.of(context).primaryColor.withOpacity(0.6)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Formaters.formatCurrency(counter[index].value.toString()),
                          style: TextStyle(fontSize: 30.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w900),
                        ),
                        kh10Spacer(),
                        Text(
                          counter[index].title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Container superAdminGridShimmer(context) {
  return Container(
    child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.w,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 20.w,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext ctx, index) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(offset: Offset(0, 0), color: Theme.of(context).shadowColor.withOpacity(0.3), blurRadius: 5.r),
                ],
                borderRadius: BorderRadius.circular(20.r),
                color: Theme.of(context).cardColor,
              ),
            ),
          );
        }),
  );
}
