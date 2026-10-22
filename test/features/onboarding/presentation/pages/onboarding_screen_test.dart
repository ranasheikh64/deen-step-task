import 'package:deen_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_action_buttons.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_bottom_silhouette.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:deen_app/features/onboarding/presentation/widgets/onboarding_skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget() {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }

  group('OnboardingScreen Widget Tests', () {
    testWidgets('renders initial onboarding view and skip button',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingBottomSilhouette), findsOneWidget);
      expect(find.byType(OnboardingSkipButton), findsOneWidget);
      expect(find.byType(OnboardingPageIndicator), findsOneWidget);
      expect(find.text('DEEN-STEP'), findsOneWidget);
    });

    testWidgets('swiping through pages updates indicator and shows action buttons on last page',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Swipe to page 2
      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();

      // Swipe to page 3
      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();

      // Swipe to page 4 (last page)
      await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();

      // Action buttons appear on last page
      expect(find.byType(OnboardingActionButtons), findsOneWidget);
    });
  });
}
