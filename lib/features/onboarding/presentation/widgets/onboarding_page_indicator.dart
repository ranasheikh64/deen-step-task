import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Page Indicator Dots for Onboarding Slides 1-3.
class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    required this.itemCount,
    required this.currentPage,
    super.key,
  });

  final int itemCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('indicator'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index ? AppColors.primary : AppColors.border,
            borderRadius: AppSpacing.roundedFull,
          ),
        ),
      ),
    );
  }
}
