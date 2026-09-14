
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/services/shared_preferences_singleton.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final isOnboardingSeen = Prefs.getBool(kIsOnboardingSeen) == true;

    if (isOnboardingSeen) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.w,
          height: 250.h,
          child: Image.asset(
            Assets.images.appLogo,
          ),
        ),
      ),
    );
  }
}
