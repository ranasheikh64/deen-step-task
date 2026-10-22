import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable center content widget for onboarding screens.
/// Matches Figma node 1:931 specifications (Deen crescent logo, Headline, Subtitle).
class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({
    required this.title,
    required this.subtitle,
    super.key,
    this.customLogo,
  });

  /// Main headline text (e.g. DEEN-STEP)
  final String title;

  /// Supporting descriptive paragraph
  final String subtitle;

  /// Optional logo override
  final Widget? customLogo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Crescent Moon Logo
          customLogo ??
              SvgPicture.asset(AssetPaths.icDeenLogo, width: 37, height: 40),
          const SizedBox(height: AppSpacing.md),

          // Main Headline (Poppins Bold 32)
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.displayLarge(color: AppColors.textPrimary)
                .copyWith(height: 1.1, letterSpacing: 0),
          ),
          const SizedBox(height: AppSpacing.md),

          // Subtitle (Poppins Regular 14)
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium(color: AppColors.textSecondary)
                .copyWith(height: 1.4, letterSpacing: 0.2),
          ),
        ],
      ),
    );
  }
}
