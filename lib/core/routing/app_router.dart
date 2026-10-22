import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/features/auth/presentation/pages/login_screen.dart';
import 'package:deen_app/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:deen_app/features/auth/presentation/pages/register_screen.dart';
import 'package:deen_app/features/auth/presentation/pages/registration_success_screen.dart';
import 'package:deen_app/features/auth/presentation/pages/too_many_attempts_screen.dart';
import 'package:deen_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:deen_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized GoRouter routing configuration.
/// Uses [AppRoutes] constants exclusively — zero hardcoded route strings.
class AppRouter {
  const AppRouter._();

  static GoRouter? _router;

  static GoRouter get router => _router ??= createRouter(AppRoutes.onboarding);

  static GoRouter createRouter([String initialLocation = AppRoutes.onboarding]) {
    return _router = GoRouter(
      initialLocation: initialLocation,
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
        builder: (context, state) {
          final email = (state.extra as String?) ?? 'user@example.com';
          return OtpVerificationScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.registrationSuccess,
        builder: (context, state) => const RegistrationSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.tooManyAttempts,
        builder: (context, state) => const TooManyAttemptsScreen(),
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
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
  }
}
