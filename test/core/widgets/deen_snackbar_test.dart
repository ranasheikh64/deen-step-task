import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeenSnackBar Tests', () {
    testWidgets('displays text-based floating snackbar at bottom', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    DeenSnackBar.show(
                      context,
                      message: 'Test notification message',
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Test notification message'), findsOneWidget);

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.behavior, equals(SnackBarBehavior.floating));
    });

    testWidgets('shows error snackbar with showError helper', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    DeenSnackBar.showError(context, 'An error occurred');
                  },
                  child: const Text('Error'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Error'));
      await tester.pump();

      expect(find.text('An error occurred'), findsOneWidget);
    });

    testWidgets('shows success snackbar with showSuccess helper', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    DeenSnackBar.showSuccess(
                      context,
                      'Operation completed successfully',
                    );
                  },
                  child: const Text('Success'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Success'));
      await tester.pump();

      expect(find.text('Operation completed successfully'), findsOneWidget);
    });
  });
}
