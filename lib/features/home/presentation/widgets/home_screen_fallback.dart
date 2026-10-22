import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/features/home/presentation/widgets/home_abundance_verse_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_ai_reflection_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_header_widget.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_tracker_card.dart';
import 'package:deen_app/features/home/presentation/widgets/home_quick_actions_grid.dart';
import 'package:deen_app/features/home/presentation/widgets/home_stats_row_widget.dart';
import 'package:flutter/material.dart';

/// Offline or test fallback rendering default Home screen widgets
class HomeScreenFallback extends StatelessWidget {
  const HomeScreenFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomePrayerHeaderWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.md),
                  HomePrayerTrackerCard(),
                  SizedBox(height: AppSpacing.md),
                  HomeStatsRowWidget(),
                  SizedBox(height: AppSpacing.md),
                  HomeAiReflectionCard(),
                  SizedBox(height: AppSpacing.md),
                  HomeAbundanceVerseCard(),
                  SizedBox(height: AppSpacing.md),
                  HomeQuickActionsGrid(),
                  SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
