import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Quick actions row featuring Qibla, Hijri, Zakat, and Times (Figma node 1:1404).
class HomeQuickActionsGrid extends StatelessWidget {
  const HomeQuickActionsGrid({
    super.key,
    this.onTapQibla,
    this.onTapHijri,
    this.onTapZakat,
    this.onTapTimes,
  });

  final VoidCallback? onTapQibla;
  final VoidCallback? onTapHijri;
  final VoidCallback? onTapZakat;
  final VoidCallback? onTapTimes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionItem(
            label: 'Qibla',
            icon: SvgPicture.asset(
              AssetPaths.icQuickQibla,
              width: 16,
              height: 16,
            ),
            onTap: onTapQibla,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildActionItem(
            label: 'Hijri',
            icon: SvgPicture.asset(
              AssetPaths.icQuickHijri,
              width: 14,
              height: 14,
            ),
            onTap: onTapHijri,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildActionItem(
            label: 'Zakat',
            icon: Text(
              r'$',
              style: AppTypography.buttonLarge(color: AppColors.homeZakatYellow)
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            onTap: onTapZakat,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildActionItem(
            label: 'Times',
            icon: SvgPicture.asset(
              AssetPaths.icQuickTimes,
              width: 16,
              height: 16,
            ),
            onTap: onTapTimes,
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required String label,
    required Widget icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.homeCardBackground.withValues(alpha: 0.6),
          borderRadius: AppSpacing.roundedLg,
          border: Border.all(color: AppColors.homeCardBorder),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 31,
              decoration: const BoxDecoration(
                color: AppColors.homeQuickActionOverlay,
                borderRadius: AppSpacing.roundedFull,
              ),
              child: Center(child: icon),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTypography.bodySmall(color: AppColors.textSecondary)
                  .copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
