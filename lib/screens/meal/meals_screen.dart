import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zappy_meal/controllers/meal/meal_cubit.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/cart_item_adder.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shimmers.dart';
import 'package:zappy_meal/shared/components/taosts.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
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
        appBar: AppBar(automaticallyImplyLeading: false, title: Text("All Meals", style: Theme.of(context).textTheme.displayMedium)),
        body: Padding(
          padding: kAppPading(),
          child: SingleChildScrollView(
            child: BlocConsumer<MealCubit, MealState>(
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
                                                showMealToast(meal: meal, context: context),
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
            ),
          ),
        ));
  }
}
