import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_checkbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Terms of Service and Privacy Policy checkbox row for Register screen.
class RegisterTermsCheckbox extends StatelessWidget {
  const RegisterTermsCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: DeenCheckbox(
            value: value,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTypography.bodySmall(
                color: AppColors.textSecondary,
              ).copyWith(height: 1.4),
              children: [
                const TextSpan(text: AuthStrings.agreeToThe),
                TextSpan(
                  text: AuthStrings.privacyPolicy,
                  style: AppTypography.buttonSmall(
                    color: AppColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.push(AppRoutes.privacyPolicy),
                ),
                const TextSpan(text: AuthStrings.and),
                TextSpan(
                  text: AuthStrings.terms,
                  style: AppTypography.buttonSmall(
                    color: AppColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.push(AppRoutes.termsAndConditions),
                ),
                TextSpan(
                  text: AuthStrings.clickHereToRead,
                  style: AppTypography.buttonSmall(
                    color: AppColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.push(AppRoutes.privacyPolicy),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
