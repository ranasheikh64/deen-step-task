import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Row of 2 cards: Daily Goal and Current Streak (Figma node 1:514).
class HomeStatsRowWidget extends StatelessWidget {
  const HomeStatsRowWidget({
    super.key,
    this.completedPrayers = 0,
    this.totalPrayers = 5,
    this.streakDays = 0,
  });

  final int completedPrayers;
  final int totalPrayers;
  final int streakDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Daily Goal',
            iconPath: AssetPaths.icDailyGoalClock,
            primaryValue: '$completedPrayers',
            secondaryValue: '/$totalPrayers',
            actionText: 'Track a prayer to\nunlock goals',
            actionColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildStatCard(
            title: 'Current Streak',
            iconPath: AssetPaths.icStreakFire,
            primaryValue: '$streakDays',
            secondaryValue: 'days',
            actionText: 'Log today to\nbegin streak',
            actionColor: AppColors.homeStreakYellow,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String iconPath,
    required String primaryValue,
    required String secondaryValue,
    required String actionText,
    required Color actionColor,
  }) {
    return Container(
      height: 157,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.navActiveBackground,
        borderRadius: AppSpacing.roundedXl,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.buttonSmall(color: AppColors.textTertiary)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SvgPicture.asset(iconPath, width: 18, height: 18),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                primaryValue,
                style: AppTypography.displayLarge(color: AppColors.textPrimary)
                    .copyWith(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 4),
              Text(
                secondaryValue,
                style: AppTypography.bodySmall(color: AppColors.textTertiary)
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            actionText,
            style: AppTypography.buttonSmall(
              color: actionColor,
            ).copyWith(fontWeight: FontWeight.w700, fontSize: 12, height: 1.2),
          ),
        ],
      ),
    );
  }
}
