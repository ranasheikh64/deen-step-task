import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
