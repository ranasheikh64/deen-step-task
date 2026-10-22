import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Single prayer item for the timeline row.
class HomePrayerTimelineItem extends StatelessWidget {
  const HomePrayerTimelineItem({
    required this.time,
    required this.name,
    required this.icon,
    this.completed = false,
    super.key,
  });

  final String time;
  final String name;
  final String icon;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final color = completed ? AppColors.primary : AppColors.textSecondary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: AppTypography.bodySmall(color: AppColors.textSecondary)
              .copyWith(fontSize: 10),
        ),
        const SizedBox(height: 4),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: completed
                ? AppColors.prayerCircleDashed
                : AppColors.prayerCircleInactive,
            shape: BoxShape.circle,
            border: Border.all(
              color: completed
                  ? AppColors.primary
                  : AppColors.prayerTimelineBorder,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: AppTypography.bodySmall(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
