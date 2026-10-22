import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/home/presentation/widgets/dotted_circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Single prayer step item on the timeline matching Figma node 1:416
class HomePrayerStepItem extends StatelessWidget {
  const HomePrayerStepItem({
    required this.time,
    required this.name,
    required this.icon,
    required this.isActive,
    required this.isPassed,
    super.key,
  });

  final String time;
  final String name;
  final String icon;
  final bool isActive;
  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: isActive
                ? AppTypography.buttonSmall(color: AppColors.homeTimeLime)
                    .copyWith(fontSize: 11, fontWeight: FontWeight.w700)
                : AppTypography.bodySmall(
                    color: isPassed ? AppColors.textPrimary : AppColors.textSecondary,
                  ).copyWith(fontSize: 10),
          ),
          const SizedBox(height: 2),
          SizedBox(
            width: 52,
            height: 52,
            child: Center(
              child: isActive ? _buildActiveCircle() : _buildRegularCircle(),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: isActive
                ? AppTypography.buttonSmall(color: AppColors.homeTimeLime)
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w700)
                : AppTypography.bodySmall(
                    color: isPassed ? AppColors.textPrimary : AppColors.textSecondary,
                  ).copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCircle() {
    return Container(
      width: 52,
      height: 52,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGlow,
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(AppColors.buttonText, BlendMode.srcIn),
        ),
      ),
    );
  }

  Widget _buildRegularCircle() {
    return CustomPaint(
      painter: isPassed
          ? const DottedCirclePainter(color: AppColors.homeTimeLime, strokeWidth: 1.5)
          : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isPassed
              ? AppColors.homeTimeLime.withValues(alpha: 0.12)
              : AppColors.prayerCircleInactive,
          shape: BoxShape.circle,
          border: isPassed ? null : Border.all(color: AppColors.prayerTimelineBorder),
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              isPassed ? AppColors.homeTimeLime : AppColors.textSecondary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
