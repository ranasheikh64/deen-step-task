import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/auth/presentation/pages/registration_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegistrationSuccessScreen Tests', () {
    testWidgets('renders success heading, message, and Go to Home button', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: RegistrationSuccessScreen()),
      );

      expect(find.text('Registration Successful'), findsOneWidget);
      expect(
        find.textContaining('Your account has been created successfully'),
        findsOneWidget,
      );
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(DeenButton), findsOneWidget);
      expect(find.text('Go to Home'), findsOneWidget);
    });
  });
}
