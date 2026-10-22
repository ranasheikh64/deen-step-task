import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/widgets/deen_nav_item.dart';
import 'package:flutter/material.dart';

export 'package:deen_app/core/widgets/deen_nav_item.dart';

/// Custom Bottom Navigation Bar matching Figma node 1:1429 (component 1:609).
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
    DeenNavItem(
      label: HomeStrings.navHome,
      iconPath: AssetPaths.icNavHome,
    ),
    DeenNavItem(
      label: HomeStrings.navCommunity,
      iconPath: AssetPaths.icNavCommunity,
    ),
    DeenNavItem(
      label: HomeStrings.navReflect,
      iconPath: AssetPaths.icNavReflect,
    ),
    DeenNavItem(
      label: HomeStrings.navPrayer,
      iconPath: AssetPaths.icNavPrayer,
    ),
    DeenNavItem(
      label: HomeStrings.navProfile,
      iconPath: AssetPaths.icNavProfile,
    ),
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
              return DeenNavItemWidget(
                item: items[index],
                isSelected: index == currentIndex,
                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}
