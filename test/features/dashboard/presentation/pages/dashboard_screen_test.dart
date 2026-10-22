import 'package:deen_app/core/widgets/deen_bottom_navigation_bar.dart';
import 'package:deen_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DashboardScreen Tests', () {
    testWidgets('renders initial tab and DeenBottomNavigationBar', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));

      expect(find.byType(DeenBottomNavigationBar), findsOneWidget);
      expect(find.text('Home Screen'), findsOneWidget);
    });

    testWidgets('switches views when bottom navigation bar item is tapped', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));

      expect(find.text('Home Screen'), findsOneWidget);

      // Tap Community
      await tester.tap(find.text('Community'));
      await tester.pumpAndSettle();
      expect(find.text('Community Screen'), findsOneWidget);

      // Tap Reflect
      await tester.tap(find.text('Reflect'));
      await tester.pumpAndSettle();
      expect(find.text('Reflect Screen'), findsOneWidget);

      // Tap Prayer
      await tester.tap(find.text('Prayer'));
      await tester.pumpAndSettle();
      expect(find.text('Prayer Screen'), findsOneWidget);

      // Tap Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);
    });
  });
}
