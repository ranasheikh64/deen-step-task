import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Active highlighted prayer item on the timeline (e.g. Dhuhr).
class HomeActivePrayerItem extends StatelessWidget {
  const HomeActivePrayerItem({
    required this.time,
    required this.name,
    required this.icon,
    super.key,
  });

  final String time;
  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: AppTypography.buttonSmall(color: AppColors.primary)
              .copyWith(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGlow,
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.buttonText,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: AppTypography.buttonSmall(color: AppColors.primary)),
      ],
    );
  }
}
