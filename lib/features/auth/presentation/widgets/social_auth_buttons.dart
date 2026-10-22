import 'package:deen_app/core/constants/app_strings.dart';
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
    this.label = AuthStrings.logInWith,
    this.isLoading = false,
    this.onGoogleTap,
    this.onAppleTap,
  });

  final String label;
  final bool isLoading;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                AuthStrings.or,
                style: AppTypography.bodySmall(color: AppColors.textTertiary),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(label, style: AppTypography.buttonSmall(color: AppColors.textTertiary)),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialCard(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset(AssetPaths.icGoogle, width: 18, height: 18),
              onTap: isLoading ? null : onGoogleTap,
            ),
            const SizedBox(width: AppSpacing.lg),
            _buildSocialCard(
              backgroundColor: AppColors.buttonSecondaryBackground,
              borderColor: AppColors.border,
              icon: SvgPicture.asset(AssetPaths.icApple, width: 18, height: 18),
              onTap: isLoading ? null : onAppleTap,
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
    return Opacity(
      opacity: isLoading ? 0.6 : 1.0,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppSpacing.roundedMd,
          border: borderColor != null ? Border.all(color: borderColor) : null,
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
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
      ),
    );
  }
}
