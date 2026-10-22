import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

void main() {
  group('OtpVerificationScreen Tests', () {
    testWidgets('renders Verify Email title, email, and 4-digit pinput', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OtpVerificationScreen(email: 'user@example.com'),
        ),
      );

      expect(find.text('Verify Email'), findsOneWidget);
      expect(find.textContaining('user@example.com'), findsOneWidget);
      expect(find.byType(Pinput), findsOneWidget);
      expect(find.text('Verify'), findsOneWidget);
      expect(find.textContaining("Didn't receive code?"), findsOneWidget);
    });

    testWidgets('Verify button is disabled until 4 digits are entered', (
      tester,
    ) async {
      final router = GoRouter(
        initialLocation: '/otp',
        routes: [
          GoRoute(
            path: '/otp',
            builder: (context, state) =>
                const OtpVerificationScreen(email: 'user@example.com'),
          ),
          GoRoute(
            path: AppRoutes.registrationSuccess,
            builder: (context, state) =>
                const Scaffold(body: Text('Registration Success Screen')),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // Initially disabled
      final initialButton = tester.widget<DeenButton>(
        find.widgetWithText(DeenButton, 'Verify'),
      );
      expect(initialButton.isEnabled, isFalse);
      expect(initialButton.onPressed, isNull);

      // Enter 3 digits -> still disabled
      await tester.enterText(find.byType(EditableText), '241');
      await tester.pump();

      final partialButton = tester.widget<DeenButton>(
        find.widgetWithText(DeenButton, 'Verify'),
      );
      expect(partialButton.isEnabled, isFalse);

      // Enter 4 digits -> enabled and verifies
      await tester.enterText(find.byType(EditableText), '2417');
      await tester.pump();

      final enabledButton = tester.widget<DeenButton>(find.byType(DeenButton));
      expect(enabledButton.isEnabled, isTrue);

      // Settle async Bloc delay and check navigation to Registration Success
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      expect(find.text('Registration Success Screen'), findsOneWidget);
    });
  });
}
