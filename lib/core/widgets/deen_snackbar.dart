import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_snackbar_theme.dart';
import 'package:flutter/material.dart';

export 'package:deen_app/core/widgets/deen_snackbar_theme.dart';

/// Centralized text-based floating bottom snackbar utility.
class DeenSnackBar {
  const DeenSnackBar._();

  /// Displays a customized text-based snackbar at the bottom of the screen
  static void show(
    BuildContext context, {
    required String message,
    DeenSnackBarType type = DeenSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final backgroundColor = DeenSnackBarTheme.getBackgroundColor(type);
    final borderColor = DeenSnackBarTheme.getBorderColor(type);
    final textColor = DeenSnackBarTheme.getTextColor(type);

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

  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: DeenSnackBarType.info,
      duration: duration,
    );
  }
}
