import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:deen_app/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Skip button displayed on top-right of onboarding screens 1-3.
class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({required this.isLastPage, super.key});

  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          right: AppSpacing.xl,
          top: AppSpacing.sm,
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isLastPage ? 0.0 : 1.0,
          child: TextButton(
            onPressed: isLastPage
                ? null
                : () => context
                    .read<OnboardingBloc>()
                    .add(const OnboardingSkipRequested()),
            child: Text(
              'Skip',
              style: AppTypography.buttonSmall(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
