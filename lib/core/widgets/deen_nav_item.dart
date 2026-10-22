import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Navigation item model for bottom navigation bar.
class DeenNavItem {
  const DeenNavItem({required this.label, required this.iconPath});

  final String label;
  final String iconPath;
}

/// Navigation item widget with active pill indicator and animations.
class DeenNavItemWidget extends StatelessWidget {
  const DeenNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final DeenNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final itemColor =
        isSelected ? AppColors.navActiveItem : AppColors.navInactiveItem;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.navActiveBackground
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 22,
              width: 24,
              child: Center(
                child: SvgPicture.asset(
                  item.iconPath,
                  height: 20,
                  width: 22,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              style: isSelected
                  ? AppTypography.buttonSmall(color: itemColor)
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 12)
                  : AppTypography.bodySmall(color: itemColor)
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
