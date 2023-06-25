import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zappy_meal/controllers/payment/payment_cubit.dart';
import 'package:zappy_meal/models/payment/psp_model.dart';
import 'package:zappy_meal/shared/components/appbar_back_btn.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/input_decorators.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/shimmers.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:zappy_meal/theme/colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    BlocProvider.of<PaymentCubit>(context).list_psps(context);
    super.initState();
  }

  int selected_index = 0;

  bool loading = true;
  bool error = false;
  List<PSPModel> psps = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appBarBackButton(context: context, icon: Icon(Icons.arrow_back)),
        title: Text("Checkout", style: Theme.of(context).textTheme.displayMedium),
        automaticallyImplyLeading: true,
        centerTitle: false,
      ),
      body: Padding(
        padding: kAppPading(),
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state is PaymentPSPListInit) {
              loading = true;
              error = false;
            }
            if (state is PaymentPSPListError) {
              loading = false;
              error = true;
            }
            if (state is PaymentPSPListSuccess) {
              psps = state.res.data['data'];
              loading = false;
              error = false;
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: kpadding(20.w, 20.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        checkoutLevel(context: context, title: "Payment", level: "01", isActive: true),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Divider(indent: 5.w, endIndent: 5.w, thickness: 1.5.h),
                          ),
                        ),
                        checkoutLevel(context: context, title: "Delivery", level: "02", isActive: false),
                      ],
                    ),
                  ),
                  kh20Spacer(),
                  // * Payment Providers section
                  loading
                      ? AppShimmers.restaurantList2Shimmer(3, context, false, true)
                      : psps.length == 0
                          ? Container(
                              height: kheight(context) * 0.5,
                              width: kwidth(context),
                              alignment: Alignment.center,
                              child: Text("No Item added to cart!"),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  ...List.generate(
                                    psps.length,
                                    (index) {
                                      bool is_selected = index == selected_index;
                                      PSPModel psp = psps[index];
                                      return GestureDetector(
                                        onTap: () => setState(() => selected_index = index),
                                        child: AnimatedContainer(
                                          duration: 800.ms,
                                          margin: EdgeInsets.only(bottom: 15.h),
                                          padding: kpadding(15.w, 20.h),
                                          decoration: BoxDecoration(
                                            borderRadius: radiusSm(),
                                            color: is_selected ? Theme.of(context).primaryColor : null,
                                            border: is_selected ? null : Border.all(color: Theme.of(context).primaryColor),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Image.asset(psp.imageUrl),
                                                  kwSpacer(20.w),
                                                  Text(
                                                    psp.name,
                                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: is_selected ? kWhite : kDark),
                                                  ),
                                                ],
                                              )),
                                              SvgPicture.asset(is_selected ? AppIcons.psp_check : AppIcons.check_square, width: 30.w)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Divider(thickness: 1.5.h),
                                  kh10Spacer(),
                                  TextField(
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    decoration: phoneInputDecorator(context: context, hint: "Enter your phone number"),
                                  ),
                                  kh10Spacer(),
                                  submitButton(context: context, onPressed: () {}, text: "Continue")
                                ],
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Column checkoutLevel({required BuildContext context, required String title, required String level, required bool isActive}) {
    return Column(
      children: [
        CircleAvatar(child: Text(level), backgroundColor: isActive ? Theme.of(context).primaryColor : Theme.of(context).highlightColor),
        khSpacer(5.h),
        Text(title, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12.sp)),
      ],
    );
  }
}
