import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/home/presentation/widgets/home_header_chips.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_timeline_row.dart';
import 'package:flutter/material.dart';

/// Top header card showing mosque scenery, current time, countdown & prayer timeline.
class HomePrayerHeaderWidget extends StatelessWidget {
  const HomePrayerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 355,
      decoration: const BoxDecoration(
        color: AppColors.homeHeaderBackground,
        borderRadius: AppSpacing.roundedXxl,
      ),
      child: ClipRRect(
        borderRadius: AppSpacing.roundedXxl,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AssetPaths.imgHomeMosqueHeader,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.35),
              ),
            ),
            Positioned(
              right: -10,
              top: 30,
              child: Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.warning,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.warning,
                      blurRadius: 40,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  const Center(
                    child: HomeLocationChip(location: 'Gulshan, Dhaka'),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '3 Jumada Al-Awwal, 1447 H',
                    style: AppTypography.bodyMedium(
                      color: AppColors.textPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _buildTimeAndDateRow('18', ':55', 'Sat, 25 Oct 2025'),
                  const SizedBox(height: AppSpacing.xs),
                  const HomeCountdownChip(
                    countdownText: 'Maghrib in 0h 29m 3s left',
                  ),
                  const Spacer(),
                  const HomePrayerTimelineRow(),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeAndDateRow(String hour, String minute, String date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: hour,
                style: const TextStyle(color: AppColors.homeTimeLime),
              ),
              TextSpan(
                text: minute,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ],
            style: AppTypography.displayLarge(color: AppColors.textPrimary)
                .copyWith(fontSize: 48, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          date,
          style: AppTypography.bodySmall(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
