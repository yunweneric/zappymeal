import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/controllers/counter/counter_cubit.dart';
import 'package:zappy_meal/controllers/login/login_cubit.dart';
import 'package:zappy_meal/controllers/meal/meal_cubit.dart';
import 'package:zappy_meal/controllers/restaurant/restaurant_cubit.dart';
import 'package:zappy_meal/layouts/base_home.dart';
import 'package:zappy_meal/models/login/verification_routing.dart';
import 'package:zappy_meal/models/restaurant/restaurant_model.dart';
import 'package:zappy_meal/screens/auth/login/verification_screen.dart';
import 'package:zappy_meal/screens/auth/login/login_screen.dart';
import 'package:zappy_meal/screens/auth/login/register_screen.dart';
import 'package:zappy_meal/screens/cart/cart_screen.dart';
import 'package:zappy_meal/screens/checkout/checkout.screen.dart';
import 'package:zappy_meal/screens/dashboard/admin/home_screen.dart';
import 'package:zappy_meal/screens/dashboard/dispatcher/home_screen.dart';
import 'package:zappy_meal/screens/dashboard/restaurant_admin/home_screen.dart';
import 'package:zappy_meal/screens/home/home_screen.dart';
import 'package:zappy_meal/screens/restaurants/restaurant_listing_screen.dart';
import 'package:zappy_meal/screens/restaurants/restaurant_screen.dart';
import 'package:zappy_meal/screens/start/splash_screen.dart';
import 'package:zappy_meal/screens/start/start_screen.dart';

import '../controllers/payment/payment_cubit.dart';
import 'index.dart';

CustomTransitionPage transitionEffect({required state, required Widget child}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
  );
}

//*----------------------------------------------------------------
//* GoRouter configuration
//*----------------------------------------------------------------

final routes = GoRouter(
  routes: [
    // ** Splash screen routes
    GoRoute(path: AppRoutes.splash, pageBuilder: (context, state) => transitionEffect(state: state, child: SplashScreen())),

    // ** Onboarding routes
    GoRoute(path: AppRoutes.start, pageBuilder: (context, state) => transitionEffect(state: state, child: StartScreen())),

    // ** Authentication routes
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: LoginScreen(),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.verify,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(
          create: (context) => LoginCubit(),
          child: VerificationScreen(
            verification_data: state.extra as VerificationRoutingResponse,
          ),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => transitionEffect(state: state, child: RegisterScreen()),
    ),

    // ** Home routes

    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => transitionEffect(state: state, child: HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.base,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RestaurantCubit(),
            ),
            BlocProvider(
              create: (context) => MealCubit(),
            ),
          ],
          child: BaseHomeLayout(),
        ),
      ),
    ),

    // * Restaurant routes
    GoRoute(
      path: AppRoutes.restaurant_listing,
      pageBuilder: (context, state) => transitionEffect(
          state: state,
          child: BlocProvider(
            create: (context) => RestaurantCubit(),
            child: RestaurantListingScreen(),
          )),
    ),
    GoRoute(
      path: AppRoutes.restaurant,
      pageBuilder: (context, state) => transitionEffect(
          state: state,
          child: BlocProvider(
            create: (context) => MealCubit(),
            child: RestaurantScreen(restaurant: state.extra as RestaurantModel),
          )),
    ),

    // * Checkout route

    GoRoute(
      path: AppRoutes.checkout,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(create: (context) => PaymentCubit(), child: CheckoutScreen()),
      ),
    ),
    GoRoute(
      path: AppRoutes.cart,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(
          create: (context) => PaymentCubit(),
          child: CartScreen(
            canPop: state.params['canPop'] as bool,
          ),
        ),
      ),
    ),

    // *----------------------------------------------------------------
    // * Dashboard Routes
    // *----------------------------------------------------------------

    GoRoute(
      path: AppRoutes.admin_home,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(create: (context) => CounterCubit(), child: AdminDashboardHome()),
      ),
    ),
    GoRoute(
      path: AppRoutes.dispatcher_home,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(create: (context) => CounterCubit(), child: DispatcherHome()),
      ),
    ),
    GoRoute(
      path: AppRoutes.restaurant_admin_home,
      pageBuilder: (context, state) => transitionEffect(
        state: state,
        child: BlocProvider(create: (context) => CounterCubit(), child: RestaurantAdminHome()),
      ),
    ),
  ],
);
