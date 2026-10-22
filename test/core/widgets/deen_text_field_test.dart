import 'package:deen_app/core/utils/validators.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeenTextField Tests', () {
    testWidgets('renders hint text and label when dynamicLabel is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DeenTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              dynamicLabel: false,
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('dynamically shows label when focused or text entered', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DeenTextField(
              labelText: 'Full Name',
              hintText: 'Enter your name',
            ),
          ),
        ),
      );

      // Initially unfocused: no label above field, hint inside field is 'Full Name'
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Enter your name'), findsNothing);

      // Tap to focus: label appears above field, hint inside is 'Enter your name'
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Enter your name'), findsOneWidget);

      // Enter text
      await tester.enterText(find.byType(TextField), 'Abid Hal');
      await tester.pumpAndSettle();

      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Abid Hal'), findsOneWidget);
    });

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

        // Before validation: no error icon or message
        expect(find.byIcon(Icons.error_outline), findsNothing);

        // Trigger form validation
        formKey.currentState!.validate();
        await tester.pumpAndSettle();

        // Displays error message and error icon
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

      // Trigger initial required error
      formKey.currentState!.validate();
      await tester.pumpAndSettle();
      expect(find.text('Email address is required'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      // Type invalid email - error updates immediately on keystroke
      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      // Type valid email - error clears immediately
      await tester.enterText(find.byType(TextField), 'test@example.com');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.byIcon(Icons.error_outline), findsNothing);
    });

    testWidgets('toggles password visibility when eye icon tapped', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DeenTextField(isPassword: true, hintText: 'Password'),
          ),
        ),
      );

      // Initial eye icon is visibility_off_outlined
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('cannot edit when enabled is false', (tester) async {
      final controller = TextEditingController(text: 'Initial');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeenTextField(controller: controller, enabled: false),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });
  });
}
