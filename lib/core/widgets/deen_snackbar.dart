import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Semantic types supported by [DeenSnackBar]
enum DeenSnackBarType {
  /// General notification
  info,

  /// Successful action
  success,

  /// Failure or validation error
  error,

  /// Cautionary alert
  warning,
}

/// Centralized text-based floating bottom snackbar utility.
/// Provides consistent, pure text-based notifications at the bottom of the screen.
class DeenSnackBar {
  const DeenSnackBar._();

  /// Displays a customized text-based snackbar at the bottom of the screen
  static void show(
    BuildContext context, {
    required String message,
    DeenSnackBarType type = DeenSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final backgroundColor = _getBackgroundColor(type);
    final borderColor = _getBorderColor(type);
    final textColor = _getTextColor(type);

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 4,
      backgroundColor: backgroundColor,
      duration: duration,
      margin: const EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: AppSpacing.xl,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.roundedMd,
        side: BorderSide(color: borderColor),
      ),
      content: Text(
        message,
        style: AppTypography.bodyMedium(color: textColor),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Convenience shortcut for error snackbars
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: DeenSnackBarType.error,
      duration: duration,
    );
  }

  /// Convenience shortcut for success snackbars
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: DeenSnackBarType.success,
      duration: duration,
    );
  }

  /// Convenience shortcut for warning snackbars
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: DeenSnackBarType.warning,
      duration: duration,
    );
  }

  static Color _getBackgroundColor(DeenSnackBarType type) {
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

  static Color _getBorderColor(DeenSnackBarType type) {
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

  static Color _getTextColor(DeenSnackBarType type) {
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
