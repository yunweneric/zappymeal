import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/controllers/cart/cart_cubit.dart';
import 'package:zappy_meal/controllers/meal/meal_cubit.dart';
import 'package:zappy_meal/models/meals/add_meal_model.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/cart_item.dart';
import 'package:zappy_meal/shared/components/cover_image.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/logger_util.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  initState() {
    BlocProvider.of<CartCubit>(context).list_items(context);
    super.initState();
  }

  List<AddMealReqModel> meals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart", style: Theme.of(context).textTheme.displayMedium)),
      body: SingleChildScrollView(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartListSuccess) {
              List<Map<String, dynamic>> res = state.res.data['data'];
              meals = res.map((e) => AddMealReqModel.fromJson(e)).toList();
            }
            return Padding(
              padding: kAppPading(),
              child: Column(
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: meals.length,
                    itemBuilder: ((context, index) {
                      AddMealReqModel meal = meals[index];
                      return cartItem(
                        context: context,
                        meal: meal,
                        onDelete: (e) {},
                        onAdd: () {
                          AddMealReqModel found_meal = meals.firstWhere((element) => element.id == meal.id);
                          found_meal.quantity = found_meal.quantity! + 1;
                          setState(() {
                            meals = [...meals, found_meal];
                          });
                          logI(found_meal.toJson());
                        },
                        onRemove: () => setState(() => meal.quantity = meal.quantity! - 1),
                      );
                    }),
                    separatorBuilder: (context, index) => Container(margin: kpv(10.h), child: Divider()),
                  ),
                  kh20Spacer(),
                  submitButton(context: context, onPressed: () => context.push(AppRoutes.checkout), text: "Checkout"),
                  khSpacer(30.h)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
