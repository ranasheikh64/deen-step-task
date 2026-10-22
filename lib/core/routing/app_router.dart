import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized GoRouter routing configuration.
/// Uses [AppRoutes] constants exclusively — zero hardcoded route strings.
class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login Screen (Coming next)')),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Sign Up Screen (Coming next)')),
        ),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Dashboard Screen (Coming next)')),
        ),
      ),
    ],
  );
}
