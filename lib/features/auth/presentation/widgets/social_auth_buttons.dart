import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable social authentication buttons section (Google & Apple)
class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({
    super.key,
    this.label = 'Log In With',
    this.onGoogleTap,
    this.onAppleTap,
  });

  final String label;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // OR Divider
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.divider, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'OR',
                style: AppTypography.bodySmall(color: AppColors.textTertiary),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.divider, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Label
        Text(
          label,
          style: AppTypography.buttonSmall(color: AppColors.textTertiary),
        ),
        const SizedBox(height: AppSpacing.md),

        // Social Icons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Button
            _buildSocialCard(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset(
                AssetPaths.icGoogle,
                width: 18,
                height: 18,
              ),
              onTap: onGoogleTap,
            ),
            const SizedBox(width: AppSpacing.lg),

            // Apple Button
            _buildSocialCard(
              backgroundColor: AppColors.buttonSecondaryBackground,
              borderColor: AppColors.border,
              icon: SvgPicture.asset(AssetPaths.icApple, width: 18, height: 18),
              onTap: onAppleTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialCard({
    required Color backgroundColor,
    required Widget icon,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppSpacing.roundedMd,
        border: borderColor != null ? Border.all(color: borderColor) : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: AppSpacing.roundedMd,
          onTap: onTap,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
