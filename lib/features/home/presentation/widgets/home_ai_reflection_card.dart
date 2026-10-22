import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// AI Reflection section card (Figma node 1:1379).
class HomeAiReflectionCard extends StatelessWidget {
  const HomeAiReflectionCard({
    super.key,
    this.message =
        'Assalamu alaikum! Welcome to your space for spiritual growth. '
        'Every big journey begins with a small step. Log your first prayer '
        'today to start building a beautiful, consistent habit',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.homeCardBackground,
        borderRadius: AppSpacing.roundedXl,
        border: Border.all(color: AppColors.homeCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AssetPaths.icAiWand, width: 15, height: 15),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'AI REFLECTION',
                    style: AppTypography.buttonSmall(color: AppColors.primary)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.homeTimeLime,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: AppTypography.bodyMedium(color: AppColors.textTertiary)
                .copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }
}
