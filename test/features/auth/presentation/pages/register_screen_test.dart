import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/core/widgets/deen_checkbox.dart';
import 'package:deen_app/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterScreen Tests', () {
    testWidgets('renders Create Account header and form elements', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Register Account'), findsOneWidget);
      expect(find.byType(DeenCheckbox), findsOneWidget);
    });

    testWidgets(
      'Register Account button is disabled until all fields are filled and terms accepted',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

        // Initially disabled
        final initialButton = tester.widget<DeenButton>(
          find.widgetWithText(DeenButton, 'Register Account'),
        );
        expect(initialButton.isEnabled, isFalse);
        expect(initialButton.onPressed, isNull);

        // Fill fields one by one
        final textFields = find.byType(TextField);
        await tester.enterText(textFields.at(0), 'Abid Hasan');
        await tester.enterText(textFields.at(1), 'abid@example.com');
        await tester.enterText(textFields.at(2), 'password123');
        await tester.enterText(textFields.at(3), 'password123');
        await tester.pumpAndSettle();

        // Still disabled because terms checkbox is unchecked
        final almostButton = tester.widget<DeenButton>(
          find.widgetWithText(DeenButton, 'Register Account'),
        );
        expect(almostButton.isEnabled, isFalse);
        expect(almostButton.onPressed, isNull);

        // Tap terms checkbox -> now enabled
        await tester.tap(find.byType(DeenCheckbox));
        await tester.pumpAndSettle();

        final enabledButton = tester.widget<DeenButton>(
          find.widgetWithText(DeenButton, 'Register Account'),
        );
        expect(enabledButton.isEnabled, isTrue);
        expect(enabledButton.onPressed, isNotNull);
      },
    );
  });
}
