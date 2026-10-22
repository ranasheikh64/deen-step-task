import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:deen_app/features/home/presentation/pages/home_screen.dart';
import 'package:deen_app/features/home/presentation/widgets/home_abundance_verse_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_ai_reflection_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_header_widget.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_tracker_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_quick_actions_grid.dart';
import 'package:deen_app/features/home/presentation/widgets/home_screen_shimmer.dart';
import 'package:deen_app/features/home/presentation/widgets/home_stats_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockHomeBloc extends Fake implements HomeBloc {
  MockHomeBloc(this._state);

  final HomeState _state;

  @override
  HomeState get state => _state;

  @override
  Stream<HomeState> get stream => Stream.value(_state);

  @override
  void add(HomeEvent event) {}

  @override
  Future<void> close() async {}
}

void main() {
  group('HomeScreen Tests', () {
    testWidgets('renders HomeScreenShimmer when uninitialized or loading', (
      tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      expect(find.byType(HomeScreenShimmer), findsOneWidget);
    });

    testWidgets('renders dynamic components when HomeLoaded state', (
      tester,
    ) async {
      const fakeDashboard = HomeDashboardEntity(

        location: UserLocationEntity(address: '37 Eastern Rd, Dhaka'),
        hijriDate: '11 Jumada al-Ula, 1448 H',
        gregorianDate: 'Thursday, 22-10-2026',
        nextPrayerName: 'Asr',
        nextPrayerTime: '15:01',
        timings: {
          'Fajr': '04:43',
          'Dhuhr': '11:43',
          'Asr': '15:01',
          'Maghrib': '17:27',
          'Isha': '18:42',
        },
        dailyGoalCompleted: 2,
        dailyGoalTarget: 5,
        streakCurrent: 4,
        aiReflection: 'Today is still untouched.',
        abundanceVerseTranslation: 'My Lord, enable me to be grateful.',
        abundanceVerseReference: 'Surah Al-Ahqaf, 46:15',
      );

      final bloc = MockHomeBloc(const HomeLoaded(dashboard: fakeDashboard));
      await tester.pumpWidget(
        MaterialApp(home: HomeScreen(homeBloc: bloc)),
      );
      await tester.pump();

      expect(find.byType(HomePrayerHeaderWidget), findsOneWidget);
      expect(find.text('37 Eastern Rd, Dhaka'), findsOneWidget);
      expect(find.text('11 Jumada al-Ula, 1448 H'), findsOneWidget);
      expect(find.text('Asr'), findsWidgets);
      expect(find.text('Fajr'), findsOneWidget);

      expect(find.byType(HomePrayerTrackerCard), findsOneWidget);
      expect(find.text('Have you prayed Asr?'), findsOneWidget);
      expect(find.text('2/5 prayers tracked today'), findsOneWidget);

      expect(find.byType(HomeStatsRowWidget), findsOneWidget);
      expect(find.text('Daily Goal'), findsOneWidget);
      expect(find.text('Current Streak'), findsOneWidget);

      expect(find.byType(HomeAiReflectionCard), findsOneWidget);
      expect(find.text('Today is still untouched.'), findsOneWidget);

      expect(find.byType(HomeAbundanceVerseCard), findsOneWidget);
      expect(find.text('Surah Al-Ahqaf, 46:15'), findsOneWidget);

      expect(find.byType(HomeQuickActionsGrid), findsOneWidget);
      expect(find.text('Qibla'), findsOneWidget);
    });
  });
}
