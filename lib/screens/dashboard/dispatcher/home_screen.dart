import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/controllers/counter/counter_cubit.dart';
import 'package:zappy_meal/models/counter/counter_model.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/screens/dashboard/widget/shimmers.dart';
import 'package:zappy_meal/shared/components/avatar_circle.dart';
import 'package:zappy_meal/shared/components/bottom_sheets.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/helpers/formaters.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/local_storage.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:zappy_meal/theme/colors.dart';

class DispatcherHome extends StatefulWidget {
  const DispatcherHome({super.key});

  @override
  State<DispatcherHome> createState() => _DispatcherHomeState();
}

class _DispatcherHomeState extends State<DispatcherHome> {
  fetchAdminCounter() {
    BlocProvider.of<CounterCubit>(context).getDispatchersCount(context);
  }

  bool loading = false;
  bool error = false;

  List<int> itemsCount = [];
  List<CounterModel> counter = [];

  @override
  void initState() {
    fetchAdminCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            kh10Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Formaters.sayGreetings(),
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Welcome Dispatcher" + "!",
                      style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // NotificationBell(),
                    SizedBox(width: 5.w),
                    InkWell(
                      onTap: () => AppBottomSheet.simpleSheet(
                        alignment: Alignment.center,
                        context: context,
                        height: 300.h,
                        padding: kpadding(20.w, 30.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Are you sure you want to log out?", style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
                            kh20Spacer(),
                            submitButton(
                              width: 200.w,
                              context: context,
                              onPressed: () async {
                                await LocalPrefs.saveToken("");
                                context.go(AppRoutes.splash);
                              },
                              text: "Yes",
                            ),
                            kh10Spacer(),
                            submitButton(
                              width: 200.w,
                              context: context,
                              onPressed: () {},
                              text: "No",
                            )
                          ],
                        ),
                      ),
                      child: avatarCircle(radius: 12.r, circleColor: Theme.of(context).primaryColor, context: context),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: kAppPading(),
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kh10Spacer(),
                  InkWell(
                    // onTap: () => Navigator.pushNamed(context, AppRoutes.viewUsersScreen),
                    child: Container(
                      width: kwidth(context),
                      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        image: DecorationImage(
                          image: AssetImage(ImageAssets.splash_image),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode.darken,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: kwidth(context) * 0.5,
                                child: Text(
                                  "Hi Dispatcher!",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              kh10Spacer(),
                              Text(
                                "Welcome to your dashboard",
                                style: TextStyle(
                                  color: kWhite,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  kh20Spacer(),
                  BlocConsumer<CounterCubit, CounterState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is CounterGetAdminCountInitial) {
                        loading = true;
                        error = false;
                      }
                      if (state is CounterGetAdminCountError) {
                        loading = false;
                        error = true;
                      }
                      if (state is CounterGetAdminCountSuccess) {
                        counter = state.response;
                        loading = false;
                        error = false;
                      }
                      return AnimatedSwitcher(
                        duration: 1200.ms,
                        child: loading
                            ? superAdminGridShimmer(context)
                            : counter.length == 0
                                ? Container()
                                : superAdminGridCards(counter, context),
                      );
                    },
                  ),
                  kh10Spacer(),
                  kh20Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
