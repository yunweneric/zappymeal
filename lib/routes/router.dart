import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/layouts/base_home.dart';
import 'package:zappy_meal/screens/auth/login_screen.dart';
import 'package:zappy_meal/screens/auth/register_screen.dart';
import 'package:zappy_meal/screens/home/home_screen.dart';
import 'package:zappy_meal/screens/start/splash_screen.dart';
import 'package:zappy_meal/screens/start/start_screen.dart';

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

    // ** Home routes

    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => transitionEffect(state: state, child: HomeScreen()),
    ),
    GoRoute(
      path: AppRoutes.base,
      pageBuilder: (context, state) => transitionEffect(state: state, child: BaseHomeLayout()),
    ),
    // ** Authentication routes
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => transitionEffect(state: state, child: LoginScreen()),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => transitionEffect(state: state, child: RegisterScreen()),
    ),
  ],
);
