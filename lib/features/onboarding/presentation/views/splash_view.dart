import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/services/shared_preferences_singleton.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/constants.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/user_profile_cubit.dart';
import 'package:strivo/test_view.dart';


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

  // 1) الـ Onboarding
  final isOnboardingSeen = Prefs.getBool(kIsOnboardingSeen) == true;
  if (!isOnboardingSeen) {
    context.go(AppRoutes.onboarding);
    return;
  }

  // 2) تسجيل الدخول
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    context.go(AppRoutes.login);
    return;
  }

  // 3) الـ Profile
  final profileCubit = context.read<UserProfileCubit>();
  await profileCubit.loadProfile();
  if (!mounted) return;

  // لو حصل خطأ في التحميل (مثلاً مفيش نت) ما نوديهوش للـ Setup غلط
  if (profileCubit.state.error != null) {
    context.go(AppRoutes.login);
    return;
  }

  if (profileCubit.state.hasCompletedProfile) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TestView(),));
  } else {
    context.go(AppRoutes.genderSelectionView);
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
