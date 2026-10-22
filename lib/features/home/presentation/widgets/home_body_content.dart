import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/presentation/widgets/home_abundance_verse_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_ai_reflection_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_tracker_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_quick_actions_grid.dart';
import 'package:deen_app/features/home/presentation/widgets/home_stats_row_widget.dart';
import 'package:flutter/material.dart';

/// Middle and lower card sections for the Home screen.
class HomeBodyContent extends StatelessWidget {
  const HomeBodyContent({required this.dashboard, super.key});

  final HomeDashboardEntity dashboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          HomePrayerTrackerCard(
            prayerName: dashboard.nextPrayerName,
            trackedCount: dashboard.dailyGoalCompleted,
            totalCount: dashboard.dailyGoalTarget,
          ),
          const SizedBox(height: AppSpacing.md),
          HomeStatsRowWidget(
            completedPrayers: dashboard.dailyGoalCompleted,
            totalPrayers: dashboard.dailyGoalTarget,
            streakDays: dashboard.streakCurrent,
          ),
          if (dashboard.aiReflection.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            HomeAiReflectionCard(message: dashboard.aiReflection),
          ],
          if (dashboard.abundanceVerseTranslation.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            HomeAbundanceVerseCard(
              source: dashboard.abundanceVerseReference,
              verse: dashboard.abundanceVerseTranslation,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          const HomeQuickActionsGrid(),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}
