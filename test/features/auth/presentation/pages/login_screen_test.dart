import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/widgets/deen_bottom_navigation_bar.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/auth/presentation/pages/login_screen.dart';
import 'package:deen_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('LoginScreen Tests', () {
    testWidgets('renders Welcome Back header and input fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
      expect(find.text('Log In With'), findsOneWidget);
    });

    testWidgets(
      'Log In button is disabled until email and password are typed',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

        // Initially disabled
        final initialButton = tester.widget<DeenButton>(
          find.widgetWithText(DeenButton, 'Log In'),
        );
        expect(initialButton.isEnabled, isFalse);
        expect(initialButton.onPressed, isNull);

        // Fill email only -> still disabled
        final textFields = find.byType(TextField);
        await tester.enterText(textFields.at(0), 'user@example.com');
        await tester.pumpAndSettle();

        final partialButton = tester.widget<DeenButton>(
          find.widgetWithText(DeenButton, 'Log In'),
        );
        expect(partialButton.isEnabled, isFalse);

        // Fill password -> now enabled
        await tester.enterText(textFields.at(1), 'password123');
        await tester.pumpAndSettle();

        final enabledButton = tester.widget<DeenButton>(
          find.widgetWithText(DeenButton, 'Log In'),
        );
        expect(enabledButton.isEnabled, isTrue);
        expect(enabledButton.onPressed, isNotNull);
      },
    );

    testWidgets(
      'successful login navigates to dashboard with bottom navigation',
      (tester) async {
        final router = GoRouter(
          initialLocation: AppRoutes.login,
          routes: [
            GoRoute(
              path: AppRoutes.login,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: AppRoutes.dashboard,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        );

        await tester.pumpWidget(MaterialApp.router(routerConfig: router));

        final textFields = find.byType(TextField);
        await tester.enterText(textFields.at(0), 'user@example.com');
        await tester.enterText(textFields.at(1), 'password123');
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(DeenButton, 'Log In'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 700));
        await tester.pumpAndSettle();

        expect(find.byType(DashboardScreen), findsOneWidget);
        expect(find.byType(DeenBottomNavigationBar), findsOneWidget);
      },
    );
  });
}
