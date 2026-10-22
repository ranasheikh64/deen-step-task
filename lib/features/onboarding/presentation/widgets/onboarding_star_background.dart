import 'package:deen_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Ambient starry background particles as specified in Figma node 1:939-1:949
class OnboardingStarBackground extends StatelessWidget {
  const OnboardingStarBackground({super.key});

  static const List<Offset> _starPositions = [
    Offset(0.15, 0.10),
    Offset(0.64, 0.08),
    Offset(0.84, 0.21),
    Offset(0.38, 0.36),
    Offset(0.81, 0.47),
    Offset(0.06, 0.67),
    Offset(0.25, 0.73),
    Offset(0.59, 0.74),
    Offset(0.87, 0.77),
    Offset(0.77, 0.83),
    Offset(0.20, 0.88),
  ];

  static const List<double> _starSizes = [
    2.0,
    1.5,
    3.0,
    2.0,
    1.5,
    2.0,
    1.5,
    2.0,
    1.5,
    1.5,
    2.0,
  ];

  static const List<double> _starOpacities = [
    0.8,
    0.5,
    0.3,
    0.7,
    0.4,
    0.6,
    0.5,
    0.7,
    0.6,
    0.5,
    0.8,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          children: List.generate(_starPositions.length, (index) {
            final pos = _starPositions[index];
            final size = _starSizes[index];
            final opacity = _starOpacities[index];

            return Positioned(
              left: pos.dx * w,
              top: pos.dy * h,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: AppColors.starParticle.withValues(alpha: opacity),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
