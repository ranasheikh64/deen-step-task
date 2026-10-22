import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:flutter/material.dart';

/// Top header for OTP Verification screen with highlighted target email.
class OtpHeader extends StatelessWidget {
  const OtpHeader({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        const DeenBackButton(),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AuthStrings.verifyEmail,
          style: AppTypography.displayLarge(
            color: AppColors.textPrimary,
          ).copyWith(height: 1.1),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text.rich(
          TextSpan(
            style: AppTypography.bodyMedium(
              color: AppColors.textSecondary,
            ).copyWith(height: 1.4),
            children: [
              const TextSpan(text: AuthStrings.otpSentTo),
              TextSpan(
                text: email,
                style: AppTypography.bodyMedium(
                  color: AppColors.primary,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
