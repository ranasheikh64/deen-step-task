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
import 'package:deen_app/features/home/presentation/widgets/home_screen_shimmer.dart';
import 'package:deen_app/features/home/presentation/widgets/home_stats_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Home Screen with live API data, real-time clock, and shimmer loading state
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.homeBloc});

  final HomeBloc? homeBloc;

  @override
  Widget build(BuildContext context) {
    if (homeBloc == null && !sl.isRegistered<HomeBloc>()) {
      return const HomeScreenShimmer();
    }
    return BlocProvider(
      create: (context) => (homeBloc ?? sl<HomeBloc>())..add(const HomeDashboardRequested()),
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
          if (state is HomeLoading || state is HomeInitial) return const HomeScreenShimmer();
          if (state is! HomeLoaded) return const SizedBox.shrink();

          final d = state.dashboard;
          final loc = d.location.address.isNotEmpty
              ? d.location.address
              : (d.location.city.isNotEmpty ? d.location.city : '');

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => context.read<HomeBloc>().add(const HomeDashboardRequested()),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  HomePrayerHeaderWidget(
                    location: loc,
                    hijriDate: d.hijriDate,
                    gregorianDate: d.gregorianDate,
                    nextPrayerName: d.nextPrayerName,
                    nextPrayerTime: d.nextPrayerTime,
                    timings: d.timings,
                    activePrayer: d.nextPrayerName,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        HomePrayerTrackerCard(
                          prayerName: d.nextPrayerName,
                          trackedCount: d.dailyGoalCompleted,
                          totalCount: d.dailyGoalTarget,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        HomeStatsRowWidget(
                          completedPrayers: d.dailyGoalCompleted,
                          totalPrayers: d.dailyGoalTarget,
                          streakDays: d.streakCurrent,
                        ),
                        if (d.aiReflection.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.md),
                          HomeAiReflectionCard(message: d.aiReflection),
                        ],
                        if (d.abundanceVerseTranslation.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.md),
                          HomeAbundanceVerseCard(
                            source: d.abundanceVerseReference,
                            verse: d.abundanceVerseTranslation,
                          ),
                        ],
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
