import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/features/auth/presentation/pages/login_screen.dart';
import 'package:deen_app/features/auth/presentation/pages/register_screen.dart';
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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Forgot Password Screen'))),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('OTP Verification Screen')),
        ),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Privacy Policy'))),
      ),
      GoRoute(
        path: AppRoutes.termsAndConditions,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Terms & Conditions'))),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Dashboard Screen'))),
      ),
    ],
  );
}
