import 'package:deen_app/features/home/presentation/pages/home_screen.dart';
import 'package:deen_app/features/home/presentation/widgets/home_abundance_verse_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_ai_reflection_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_header_widget.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_tracker_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_quick_actions_grid.dart';
import 'package:deen_app/features/home/presentation/widgets/home_stats_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeScreen Tests', () {
    testWidgets('renders all section components and key text in HomeScreen', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // 1. Header with location and prayer times
      expect(find.byType(HomePrayerHeaderWidget), findsOneWidget);
      expect(find.text('Gulshan, Dhaka'), findsOneWidget);
      expect(find.text('3 Jumada Al-Awwal, 1447 H'), findsOneWidget);
      expect(find.text('Dhuhr'), findsOneWidget);
      expect(find.text('Fajr'), findsOneWidget);
      expect(find.text('Asr'), findsOneWidget);
      expect(find.text('Maghrib'), findsOneWidget);
      expect(find.text('Isha'), findsOneWidget);

      // 2. Prayer tracker card
      expect(find.byType(HomePrayerTrackerCard), findsOneWidget);
      expect(find.text('Have you prayed Dhuhr?'), findsOneWidget);
      expect(find.text('2/5 prayers tracked today'), findsOneWidget);

      // 3. Stats row
      expect(find.byType(HomeStatsRowWidget), findsOneWidget);
      expect(find.text('Daily Goal'), findsOneWidget);
      expect(find.text('Current Streak'), findsOneWidget);

      // 4. AI reflection card
      expect(find.byType(HomeAiReflectionCard), findsOneWidget);
      expect(find.text('AI REFLECTION'), findsOneWidget);

      // 5. Abundance verse card
      expect(find.byType(HomeAbundanceVerseCard), findsOneWidget);
      expect(find.text('ABUNDANCE VERSE'), findsOneWidget);
      expect(find.text('Sahih al-Bukhari, 6412'), findsOneWidget);

      // 6. Quick action grid
      expect(find.byType(HomeQuickActionsGrid), findsOneWidget);
      expect(find.text('Qibla'), findsOneWidget);
      expect(find.text('Hijri'), findsOneWidget);
      expect(find.text('Zakat'), findsOneWidget);
      expect(find.text('Times'), findsOneWidget);
    });
  });
}
