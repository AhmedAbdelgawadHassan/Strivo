import 'package:go_router/go_router.dart';
import 'package:strivo/features/auth/presentation/views/login_view.dart';
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
    ],
  );
}
