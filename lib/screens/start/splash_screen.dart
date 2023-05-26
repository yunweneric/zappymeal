import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/shared/utils/image_assets.dart';
import 'package:zappy_meal/shared/utils/local_storage.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    reRouteUser();
    super.initState();
  }

  reRouteUser() async {
    // await LocalPrefs.saveInit(Hello);
    bool hasInit = await LocalPrefs.getInit();

    if (!hasInit) {
      Future.delayed(1200.ms, () {
        context.go(AppRoutes.start);
      });
    } else {
      var is_authencated = await LocalPrefs.getToken();
      if (is_authencated == null || is_authencated == "") {
        Future.delayed(1200.ms, () => context.go(AppRoutes.login));
      } else {
        Future.delayed(1200.ms, () => context.go(AppRoutes.base));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: kheight(context),
        width: kwidth(context),
        child: Bounce(child: Image.asset(ImageAssets.logo_and_name, scale: 2)),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(1),
          image: DecorationImage(
            image: AssetImage(ImageAssets.splash_image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
