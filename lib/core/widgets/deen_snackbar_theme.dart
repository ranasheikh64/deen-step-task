import 'package:deen_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Semantic types supported by DeenSnackBar.
enum DeenSnackBarType {
  info,
  success,
  error,
  warning,
}

/// Color mappings for DeenSnackBar types.
class DeenSnackBarTheme {
  const DeenSnackBarTheme._();

  static Color getBackgroundColor(DeenSnackBarType type) {
    switch (type) {
      case DeenSnackBarType.error:
        return const Color(0xFF261214);
      case DeenSnackBarType.success:
        return const Color(0xFF142217);
      case DeenSnackBarType.warning:
        return const Color(0xFF261D0F);
      case DeenSnackBarType.info:
        return AppColors.card;
    }
  }

  static Color getBorderColor(DeenSnackBarType type) {
    switch (type) {
      case DeenSnackBarType.error:
        return AppColors.error;
      case DeenSnackBarType.success:
        return AppColors.primary;
      case DeenSnackBarType.warning:
        return AppColors.warning;
      case DeenSnackBarType.info:
        return AppColors.border;
    }
  }

  static Color getTextColor(DeenSnackBarType type) {
    switch (type) {
      case DeenSnackBarType.error:
        return const Color(0xFFFF8B8B);
      case DeenSnackBarType.success:
        return AppColors.primary;
      case DeenSnackBarType.warning:
        return const Color(0xFFFFD480);
      case DeenSnackBarType.info:
        return AppColors.textPrimary;
    }
  }
}
