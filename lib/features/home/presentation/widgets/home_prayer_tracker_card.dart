import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Floating prayer tracker card asking "Have you prayed Dhuhr?" (Figma node 1:1369).
class HomePrayerTrackerCard extends StatelessWidget {
  const HomePrayerTrackerCard({
    super.key,
    this.prayerName = 'Dhuhr',
    this.trackedCount = 2,
    this.totalCount = 5,
    this.onTapQuestion,
  });

  final String prayerName;
  final int trackedCount;
  final int totalCount;
  final VoidCallback? onTapQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.homeCardBackground,
        borderRadius: AppSpacing.roundedLg,
        border: Border.all(color: AppColors.homeCardBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Have you prayed $prayerName?',
                style: AppTypography.buttonMedium(color: AppColors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                '$trackedCount/$totalCount prayers tracked today',
                style: AppTypography.bodySmall(color: AppColors.textSecondary)
                    .copyWith(fontSize: 12),
              ),
            ],
          ),
          InkWell(
            onTap: onTapQuestion,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.homeChipBackground),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AssetPaths.icQuestionMark,
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
