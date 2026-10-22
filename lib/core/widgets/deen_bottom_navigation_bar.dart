import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Navigation item model for [DeenBottomNavigationBar]
class DeenNavItem {
  const DeenNavItem({required this.label, required this.iconPath});

  final String label;
  final String iconPath;
}

/// Custom Bottom Navigation Bar matching Figma node 1:1429 (component 1:609).
/// Features:
/// - Dark themed curved container with 24px top-rounded corners
/// - 5 standard items (Home, Community, Reflect, Prayer, Profile)
/// - Active item highlighted with a 64x64 pill container (#0F1612),
///   lime icon and text (#B9EB42, Poppins Bold 12px)
/// - Inactive items with muted slate color (#475569, Poppins Regular 12px)
/// - Smooth animated transitions and safe area padding
class DeenBottomNavigationBar extends StatelessWidget {
  const DeenBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
    this.items = defaultItems,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<DeenNavItem> items;

  static const List<DeenNavItem> defaultItems = [
    DeenNavItem(label: 'Home', iconPath: AssetPaths.icNavHome),
    DeenNavItem(label: 'Community', iconPath: AssetPaths.icNavCommunity),
    DeenNavItem(label: 'Reflect', iconPath: AssetPaths.icNavReflect),
    DeenNavItem(label: 'Prayer', iconPath: AssetPaths.icNavPrayer),
    DeenNavItem(label: 'Profile', iconPath: AssetPaths.icNavProfile),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(color: AppColors.border.withValues(alpha: 0.3)),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, bottomPadding > 0 ? 4 : 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = index == currentIndex;
              final item = items[index];

              return _NavItemWidget(
                item: item,
                isSelected: isSelected,
                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  const _NavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final DeenNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final itemColor = isSelected
        ? AppColors.navActiveItem
        : AppColors.navInactiveItem;

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
