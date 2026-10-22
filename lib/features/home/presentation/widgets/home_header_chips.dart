import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Pill chip displaying current location with pin icon.
class HomeLocationChip extends StatelessWidget {
  const HomeLocationChip({required this.location, super.key});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.homeChipBackground,
        borderRadius: AppSpacing.roundedFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AssetPaths.icLocationPin, width: 16, height: 16),
          const SizedBox(width: AppSpacing.xs),
          Text(
            location,
            style: AppTypography.buttonSmall(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

/// Pill chip displaying next prayer countdown with clock icon.
class HomeCountdownChip extends StatelessWidget {
  const HomeCountdownChip({required this.countdownText, super.key});

  final String countdownText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.homeChipBackground,
        borderRadius: AppSpacing.roundedFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AssetPaths.icCountdownClock, width: 14, height: 14),
          const SizedBox(width: AppSpacing.xs),
          Text(
            countdownText,
            style: AppTypography.buttonSmall(
              color: AppColors.homeCountdownMuted,
            ),
          ),
        ],
      ),
    );
  }
}
