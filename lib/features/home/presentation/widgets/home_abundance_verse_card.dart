import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Abundance Verse section card (Figma node 1:1389).
class HomeAbundanceVerseCard extends StatelessWidget {
  const HomeAbundanceVerseCard({
    super.key,
    this.source = 'Sahih al-Bukhari, 6412',
    this.verse = 'Start your daily verse by input them in reflections.',
  });

  final String source;
  final String verse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.homeCardBackground.withValues(alpha: 0.8),
        borderRadius: AppSpacing.roundedXl,
        border: Border.all(color: AppColors.homeCardBorder),
      ),
      child: ClipRRect(
        borderRadius: AppSpacing.roundedXl,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 140,
              child: Image.asset(
                AssetPaths.imgQuranVerseBg,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AssetPaths.icVerseBook,
                            width: 16,
                            height: 14,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'ABUNDANCE VERSE',
                            style: AppTypography.buttonSmall(
                              color: AppColors.textPrimary,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Text(
                        source,
                        style: AppTypography.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    verse,
                    style: AppTypography.bodyMedium(
                      color: AppColors.textTertiary,
                    ).copyWith(height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
