import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Footer link for contacting support on the lockout screen.
class LockoutSupportFooter extends StatelessWidget {
  const LockoutSupportFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 16,
            color: AppColors.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text.rich(
            TextSpan(
              style: AppTypography.bodySmall(
                color: AppColors.textSecondary,
              ),
              children: [
                const TextSpan(text: AuthStrings.needHelp),
                TextSpan(
                  text: AuthStrings.contactSupport,
                  style: AppTypography.buttonSmall(
                    color: AppColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => DeenSnackBar.showInfo(
                          context,
                          AuthStrings.supportContactInfo,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
