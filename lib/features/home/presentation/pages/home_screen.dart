import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:deen_app/features/home/presentation/widgets/enable_location_dialog.dart';
import 'package:deen_app/features/home/presentation/widgets/home_abundance_verse_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_ai_reflection_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_header_widget.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_tracker_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_quick_actions_grid.dart';
import 'package:deen_app/features/home/presentation/widgets/home_screen_fallback.dart';
import 'package:deen_app/features/home/presentation/widgets/home_stats_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Home Screen matching Figma node 1:1335 with live API data and location dialog
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.homeBloc});

  final HomeBloc? homeBloc;

  @override
  Widget build(BuildContext context) {
    if (homeBloc == null && !sl.isRegistered<HomeBloc>()) {
      return const HomeScreenFallback();
    }
    return BlocProvider(
      create: (context) =>
          (homeBloc ?? sl<HomeBloc>())..add(const HomeDashboardRequested()),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded && state.showLocationDialog) {
            EnableLocationDialog.show(
              context,
              onTurnOnLocation: () =>
                  context.read<HomeBloc>().add(const HomeLocationPermissionRequested()),
            );
          }
        },
        builder: (context, state) {
          final d = state is HomeLoaded ? state.dashboard : null;
          final cd = d != null && d.nextPrayerName.isNotEmpty
              ? '${d.nextPrayerName} in ${d.nextPrayerSecondsUntil ~/ 3600}h ${(d.nextPrayerSecondsUntil % 3600) ~/ 60}m left'
              : 'Maghrib in 0h 29m 3s left';

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => context.read<HomeBloc>().add(const HomeDashboardRequested()),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  HomePrayerHeaderWidget(
                    location: d?.location.address.isNotEmpty == true ? d!.location.address : 'Gulshan, Dhaka',
                    hijriDate: d?.hijriDate.isNotEmpty == true ? d!.hijriDate : '3 Jumada Al-Awwal, 1447 H',
                    gregorianDate: d?.gregorianDate.isNotEmpty == true ? d!.gregorianDate : 'Sat, 25 Oct 2025',
                    countdownText: cd,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        const HomePrayerTrackerCard(),
                        const SizedBox(height: AppSpacing.md),
                        HomeStatsRowWidget(
                          completedPrayers: d?.dailyGoalCompleted ?? 0,
                          totalPrayers: d?.dailyGoalTarget ?? 5,
                          streakDays: d?.streakCurrent ?? 0,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        HomeAiReflectionCard(
                          message: d?.aiReflection.isNotEmpty == true
                              ? d!.aiReflection
                              : 'Assalamu alaikum! Welcome to your space for spiritual growth.',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        HomeAbundanceVerseCard(
                          source: d?.abundanceVerseReference.isNotEmpty == true
                              ? d!.abundanceVerseReference
                              : 'Sahih al-Bukhari, 6412',
                          verse: d?.abundanceVerseTranslation.isNotEmpty == true
                              ? d!.abundanceVerseTranslation
                              : 'Start your daily verse by input them in reflections.',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const HomeQuickActionsGrid(),
                        const SizedBox(height: AppSpacing.xxxl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
