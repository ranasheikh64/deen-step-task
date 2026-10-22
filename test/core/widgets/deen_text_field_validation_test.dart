import 'package:deen_app/core/utils/validators.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeenTextField Validation Tests', () {
    testWidgets(
      'triggers validator on invalid input and shows error icon on left',
      (tester) async {
        final formKey = GlobalKey<FormState>();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: formKey,
                child: const DeenTextField(validator: AppValidators.email),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.error_outline), findsNothing);

        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        expect(find.text('Email address is required'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      },
    );

    testWidgets('updates validation state in real time as user types', (
      tester,
    ) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: const DeenTextField(validator: AppValidators.email),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();
      expect(find.text('Email address is required'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'test@example.com');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.byIcon(Icons.error_outline), findsNothing);
    });
  });
}
