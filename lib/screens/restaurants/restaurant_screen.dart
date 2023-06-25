import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/controllers/meal/meal_cubit.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/models/restaurant/restaurant_model.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/cart_item_adder.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shimmers.dart';
import 'package:zappy_meal/shared/components/taosts.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class RestaurantScreen extends StatefulWidget {
  final RestaurantModel restaurant;
  const RestaurantScreen({super.key, required this.restaurant});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  bool loading = true;
  bool error = false;

  List<MealModel> meals = [];
  @override
  void initState() {
    BlocProvider.of<MealCubit>(context).list_meals(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kheight(context),
        width: kwidth(context),
        child: Stack(
          children: [
            Container(
              height: kheight(context) * 0.4,
              child: Stack(
                children: [
                  coverImage(context: context, height: 300.h, url: widget.restaurant.imageUrl),
                  Positioned(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 20.r,
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    top: 60,
                    left: 25,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: kheight(context) * 0.7,
                width: kwidth(context),
                decoration: BoxDecoration(
                  borderRadius: radiusL(),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: kpadding(20.w, 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Container(
                                width: 110.w,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                padding: kpadding(5.w, 5.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.send_envelop),
                                    kwSpacer(5.w),
                                    Text("Less Than 500 m", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp)),
                                  ],
                                ),
                              ),
                            ),
                            khSpacer(5.h),
                            SizedBox(
                              width: kwidth(context) * 0.4,
                              child: Text(
                                widget.restaurant.location.locationName,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                maxLines: 1,
                              ),
                            ),
                            kh10Spacer(),
                            Text(widget.restaurant.name, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor)),
                            khSpacer(5.h),
                            Row(
                              children: List.generate(
                                4,
                                (index) => SvgPicture.asset(AppIcons.star, width: 15.w),
                              ),
                            ),
                            kh10Spacer(),
                            Text(widget.restaurant.description),
                          ],
                        ),
                      ),
                      Divider(),
                      kh10Spacer(),
                      Container(
                        padding: kAppPading(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("List of Meals", style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).primaryColor)),
                            BlocConsumer<MealCubit, MealState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is MealListInit) {
                                  loading = true;
                                  error = false;
                                }
                                if (state is MealListError) {
                                  loading = false;
                                  error = true;
                                }
                                if (state is MealListSuccess) {
                                  loading = false;
                                  error = false;
                                  meals = state.res;
                                }
                                return loading
                                    ? AppShimmers.gridRestaurantShimmer(6, context, false)
                                    : meals.length == 0
                                        ? Container(
                                            child: Center(
                                              child: Text("No meals available"),
                                            ),
                                          )
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            padding: kpadding(0, 15.h),
                                            physics: NeverScrollableScrollPhysics(),
                                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 200.w,
                                              childAspectRatio: 4 / 6,
                                              crossAxisSpacing: 10.w,
                                              mainAxisSpacing: 10.w,
                                            ),
                                            itemCount: meals.length,
                                            itemBuilder: (BuildContext ctx, index) {
                                              MealModel meal = meals[index];
                                              return Container(
                                                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: radiusM()),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    coverImage(borderRadius: 10.r, context: context, height: 80.h, url: meal.imageUrl),
                                                    Container(
                                                      padding: kpadding(10.w, 2.h),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          khSpacer(10.h),
                                                          Text(meal.name, style: Theme.of(context).textTheme.displaySmall, maxLines: 1),
                                                          Text(
                                                            Formaters.formatCurrency(meal.price) + " " + meal.restaurant.country.currencyCode,
                                                            maxLines: 1,
                                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor),
                                                          ),
                                                          khSpacer(10.h),
                                                          cartAdderAndRemover(
                                                            context: context,
                                                            onAdd: () {},
                                                            quantity: "3",
                                                            onRemove: () {},
                                                            itemPadding: kpadding(8.w, 7.w),
                                                            width: 100.w,
                                                          ),
                                                          khSpacer(5.h),
                                                          submitButton(
                                                            width: 100.w,
                                                            context: context,
                                                            onPressed: () {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                showMealToast(meal: MockData.meal(Faker()), context: context),
                                                              );
                                                            },
                                                            padding: kpadding(5.w, 5.h),
                                                            text: "Add to cart",
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
