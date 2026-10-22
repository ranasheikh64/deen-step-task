import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeenButton Tests', () {
    testWidgets('renders button text properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeenButton(text: 'Create Account', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Create Account'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('calls onPressed when tapped in enabled state', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeenButton(
              text: 'Create Account',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DeenButton));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeenButton(
              text: 'Create Account',
              isEnabled: false,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DeenButton));
      await tester.pump();

      expect(tapped, isFalse);
    });

    testWidgets(
      'shows loading indicator when isLoading is true and ignores tap',
      (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeenButton(
                text: 'Create Account',
                isLoading: true,
                onPressed: () => tapped = true,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Create Account'), findsNothing);

        await tester.tap(find.byType(DeenButton));
        await tester.pump();

        expect(tapped, isFalse);
      },
    );
  });
}
