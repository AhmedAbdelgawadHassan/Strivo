import 'package:go_router/go_router.dart';
import 'package:strivo/features/auth/presentation/views/forget_password_view.dart';
import 'package:strivo/features/auth/presentation/views/login_view.dart';
import 'package:strivo/features/auth/presentation/views/signup_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/activity_level_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/body_measurements_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/fitness_goal_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/gender_selection_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/review_profile_view.dart';
import 'package:strivo/features/onboarding/presentation/views/onbaording_view.dart';
import 'package:strivo/features/onboarding/presentation/views/splash_view.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashView();
        },
      ),

      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) {
          return const OnboardingView();
        },
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return const LoginView();
        },
      ),

       GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) {
          return const ForgetPasswordView();
        },
      ),

       GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) {
          return const SignupView();
        },
      ),

      GoRoute(path: AppRoutes.genderSelectionView, builder: (context, state) {
        return const GenderSelectionView();
        },),


         GoRoute(path: AppRoutes.fitnessGoal, builder: (context, state) {
        return const FitnessGoalView();
        },),


         GoRoute(path: AppRoutes.bodyMeasurements, builder: (context, state) {
        return const BodyMeasurementsView();
        },),


         GoRoute(path: AppRoutes.reviewProfile, builder: (context, state) {
        return const ReviewProfileView();
        },),

         GoRoute(path: AppRoutes.activityLevelView, builder: (context, state) {
        return const ActivityLevelView();
        },),


      
    ],
  );
}
