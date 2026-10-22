import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Resend code countdown and action section for OTP verification.
class OtpResendSection extends StatelessWidget {
  const OtpResendSection({
    required this.secondsRemaining,
    required this.onResend,
    super.key,
  });

  final int secondsRemaining;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final timerString =
        '00:${secondsRemaining.toString().padLeft(2, '0')}';

    return Center(
      child: Text.rich(
        TextSpan(
          style: AppTypography.bodyMedium(
            color: AppColors.textSecondary,
          ),
          children: [
            const TextSpan(text: AuthStrings.didNotReceiveCode),
            if (secondsRemaining > 0)
              TextSpan(
                text: '${AuthStrings.resendIn}$timerString',
                style: AppTypography.buttonMedium(
                  color: AppColors.primary,
                ),
              )
            else
              TextSpan(
                text: AuthStrings.resendCode,
                style: AppTypography.buttonMedium(
                  color: AppColors.primary,
                ),
                recognizer: TapGestureRecognizer()..onTap = onResend,
              ),
          ],
        ),
      ),
    );
  }
}
