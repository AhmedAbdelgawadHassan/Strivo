import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/features/auth/presentation/views/forget_password_view.dart';
import 'package:strivo/features/auth/presentation/views/login_view.dart';
import 'package:strivo/features/auth/presentation/views/signup_view.dart';
import 'package:strivo/features/fitnessProfileSetup/data/repos/fitness_profile_repository.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/fitness_setup_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/activity_level_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/body_measurements_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/fitness_goal_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/gender_selection_view.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/review_profile_view.dart';
import 'package:strivo/features/onboarding/presentation/views/onbaording_view.dart';
import 'package:strivo/features/onboarding/presentation/views/splash_view.dart';


class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupView(),
      ),

      // ====== Fitness Setup Flow: كلهم بيشاركوا نفس الـ Cubit ======
     /* فكرة ال shellRouters  هي انك بتجمع راوترز مع بعض وتديهم مثلا نفس الكيوبت*/
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) =>
                FitnessSetupCubit(context.read<FitnessProfileRepository>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.genderSelectionView,
            builder: (context, state) => const GenderSelectionView(),
          ),
          GoRoute(
            path: AppRoutes.bodyMeasurements,
            builder: (context, state) => const BodyMeasurementsView(),
          ),
          GoRoute(
            path: AppRoutes.reviewProfile,
            builder: (context, state) => const ReviewProfileView(),
          ),
          GoRoute(
            path: AppRoutes.fitnessGoal,
            builder: (context, state) => const FitnessGoalView(),
          ),
          GoRoute(
            path: AppRoutes.activityLevelView,
            builder: (context, state) => const ActivityLevelView(),
          ),
        ],
      ),
    ],
  );
}