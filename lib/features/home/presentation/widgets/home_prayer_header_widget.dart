import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/home/presentation/widgets/home_header_chips.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_timeline_row.dart';
import 'package:flutter/material.dart';

/// Full-width edge-to-edge mosque header with notch/status-bar integration.
class HomePrayerHeaderWidget extends StatelessWidget {
  const HomePrayerHeaderWidget({super.key});

  static const _bottomRadius = BorderRadius.vertical(
    bottom: Radius.circular(AppSpacing.radiusXxl),
  );

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      height: 360 + topPadding,
      decoration: const BoxDecoration(
        color: AppColors.homeHeaderBackground,
        borderRadius: _bottomRadius,
      ),
      child: ClipRRect(
        borderRadius: _bottomRadius,
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
              top: topPadding + 10,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.homeSunCore,
                      AppColors.homeSunGlow.withValues(alpha: 0.75),
                      AppColors.homeSunOuter.withValues(alpha: 0.3),
                      AppColors.transparent,
                    ],
                    stops: const [0.0, 0.45, 0.75, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                topPadding + AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const HomeTimeAndDateDisplay(
                    hour: '18',
                    minute: ':55',
                    date: 'Sat, 25 Oct 2025',
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const HomeCountdownChip(
                    countdownText: 'Maghrib in 0h 29m 3s left',
                  ),
                  const Spacer(),
                  const HomePrayerTimelineRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
