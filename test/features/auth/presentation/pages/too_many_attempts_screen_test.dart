import 'package:deen_app/features/auth/presentation/pages/too_many_attempts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TooManyAttemptsScreen Tests', () {
    testWidgets('renders lock icon, time remaining card, and contact support', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: TooManyAttemptsScreen()));

      expect(find.text('Too Many Attempts'), findsOneWidget);
      expect(find.text('TIME REMAINING'), findsOneWidget);
      expect(find.byIcon(Icons.lock_rounded), findsOneWidget);
      expect(find.textContaining('Contact Support'), findsOneWidget);
    });
  });
}
