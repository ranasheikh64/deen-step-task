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
          Flexible(
            child: Text(
              location,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buttonSmall(color: AppColors.textPrimary),
            ),
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

/// Formatted large digital clock with colored hour and gregorian date.
class HomeTimeAndDateDisplay extends StatelessWidget {
  const HomeTimeAndDateDisplay({
    required this.hour,
    required this.minute,
    required this.date,
    super.key,
  });

  final String hour;
  final String minute;
  final String date;

  @override
  Widget build(BuildContext context) {
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
