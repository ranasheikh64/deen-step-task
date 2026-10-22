import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:flutter/material.dart';

/// Top header section for the Login screen.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        const DeenBackButton(),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AuthStrings.welcomeBack,
          style: AppTypography.displayLarge(
            color: AppColors.textPrimary,
          ).copyWith(height: 1.1),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AuthStrings.loginSubtitle,
          style: AppTypography.bodyMedium(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
