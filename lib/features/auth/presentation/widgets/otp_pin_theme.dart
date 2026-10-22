import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// Pinput theme configurations matching Figma node 1:807.
class OtpPinThemes {
  const OtpPinThemes._();

  static PinTheme defaultTheme({required bool hasError}) {
    return PinTheme(
      width: 70,
      height: 74,
      textStyle: AppTypography.headlineLarge(
        color: AppColors.textPrimary,
      ).copyWith(fontWeight: FontWeight.w700, fontSize: 24),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasError ? AppColors.error : AppColors.inputBorder,
          width: hasError ? 1.5 : 1,
        ),
      ),
    );
  }

  static PinTheme focusedTheme({required bool hasError}) {
    return defaultTheme(hasError: hasError).copyWith(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasError ? AppColors.error : AppColors.primary,
          width: 1.5,
        ),
      ),
    );
  }
}
