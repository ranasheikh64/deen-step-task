import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Card displaying the countdown time remaining for account lockout.
class LockoutTimerCard extends StatelessWidget {
  const LockoutTimerCard({
    required this.formattedTime,
    super.key,
  });

  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.roundedLg,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.access_time_rounded,
            size: 22,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            formattedTime,
            style: AppTypography.displayLarge(color: AppColors.primary)
                .copyWith(fontSize: 44, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            AuthStrings.timeRemaining,
            style: AppTypography.bodySmall(color: AppColors.textTertiary)
                .copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}
