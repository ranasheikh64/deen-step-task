import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/home/presentation/widgets/dotted_circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Single prayer item on the timeline row with centered circle alignment
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
    return SizedBox(
      width: 52,
      height: 94,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 6,
            child: Text(
              time,
              style: AppTypography.bodySmall(
                color: completed ? AppColors.textPrimary : AppColors.textSecondary,
              ).copyWith(fontSize: 10),
            ),
          ),
          Positioned(
            top: 27,
            child: CustomPaint(
              painter: completed
                  ? const DottedCirclePainter(color: AppColors.homeTimeLime)
                  : null,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: completed
                      ? AppColors.homeTimeLime.withValues(alpha: 0.12)
                      : AppColors.prayerCircleInactive,
                  shape: BoxShape.circle,
                  border: completed
                      ? null
                      : Border.all(color: AppColors.prayerTimelineBorder),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      completed ? AppColors.homeTimeLime : AppColors.textSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            child: Text(
              name,
              style: AppTypography.bodySmall(
                color: completed ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
