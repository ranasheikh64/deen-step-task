import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/widgets/deen_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeenBottomNavigationBar Tests', () {
    testWidgets('renders all 5 navigation items with labels and SVG icons', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: DeenBottomNavigationBar(
              currentIndex: 0,
              onTap: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Community'), findsOneWidget);
      expect(find.text('Reflect'), findsOneWidget);
      expect(find.text('Prayer'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNWidgets(5));
    });

    testWidgets('calls onTap with correct index when an item is clicked', (
      tester,
    ) async {
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: DeenBottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      // Tap Community (index 1)
      await tester.tap(find.text('Community'));
      await tester.pump();
      expect(selectedIndex, equals(1));

      // Tap Prayer (index 3)
      await tester.tap(find.text('Prayer'));
      await tester.pump();
      expect(selectedIndex, equals(3));
    });

    testWidgets('active item highlights with active pill background', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: DeenBottomNavigationBar(
              currentIndex: 2, // Reflect selected
              onTap: (_) {},
            ),
          ),
        ),
      );

      // Find AnimatedContainer corresponding to items
      final animatedContainers = tester.widgetList<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );

      // Verify that at least one container has active background color
      final hasActiveBackground = animatedContainers.any((c) {
        final decoration = c.decoration as BoxDecoration?;
        return decoration?.color == AppColors.navActiveBackground;
      });

      expect(hasActiveBackground, isTrue);
    });
  });
}
