import 'package:deen_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Style variants supported by DeenButton.
enum DeenButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

/// Helper functions for styling DeenButton.
class DeenButtonStyle {
  const DeenButtonStyle._();

  static Color getBackgroundColor({
    required DeenButtonVariant variant,
    required bool isClickable,
  }) {
    if (!isClickable) {
      return variant == DeenButtonVariant.primary
          ? AppColors.buttonDisabled
          : AppColors.transparent;
    }

    switch (variant) {
      case DeenButtonVariant.primary:
        return AppColors.buttonPrimary;
      case DeenButtonVariant.secondary:
        return AppColors.buttonSecondaryBackground;
      case DeenButtonVariant.outline:
      case DeenButtonVariant.ghost:
        return AppColors.transparent;
    }
  }

  static Color getForegroundColor({
    required DeenButtonVariant variant,
    required bool isClickable,
  }) {
    if (!isClickable) {
      return AppColors.buttonDisabledText;
    }

    switch (variant) {
      case DeenButtonVariant.primary:
        return AppColors.buttonText;
      case DeenButtonVariant.secondary:
        return AppColors.buttonSecondaryText;
      case DeenButtonVariant.outline:
      case DeenButtonVariant.ghost:
        return AppColors.textPrimary;
    }
  }

  static Border? getBorder({
    required DeenButtonVariant variant,
    required bool isClickable,
  }) {
    if (variant == DeenButtonVariant.outline) {
      return Border.all(
        color: isClickable ? AppColors.buttonBorder : AppColors.border,
      );
    }
    return null;
  }
}
