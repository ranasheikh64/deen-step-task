import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Error text indicating remaining attempts after incorrect OTP entry.
class OtpIncorrectCodeWidget extends StatelessWidget {
  const OtpIncorrectCodeWidget({
    required this.remainingAttempts,
    super.key,
  });

  final int remainingAttempts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        '${AuthStrings.incorrectCodePrefix}$remainingAttempts${AuthStrings.attemptsRemainingSuffix}',
        style: AppTypography.bodySmall(color: AppColors.error),
      ),
    );
  }
}
