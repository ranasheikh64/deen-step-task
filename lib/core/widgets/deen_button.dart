import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Style variants supported by [DeenButton]
enum DeenButtonVariant {
  /// Primary vibrant lime green button (Figma node 1:1009)
  primary,

  /// Secondary dark card button
  secondary,

  /// Outlined button with colored border
  outline,

  /// Transparent background button
  ghost,
}

/// Custom button component matching Figma design specifications (node 1:1009).
/// Supports enabled, disabled, and loading states without any hardcoded colors.
class DeenButton extends StatelessWidget {
  const DeenButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = DeenButtonVariant.primary,
    this.width,
    this.height = 54,
    this.icon,
    this.borderRadius,
  });

  /// The button label text
  final String text;

  /// Callback when button is tapped. Disabled if null.
  final VoidCallback? onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Whether the button is interactable
  final bool isEnabled;

  /// Visual variant of the button
  final DeenButtonVariant variant;

  /// Optional fixed width. Defaults to full available width if null.
  final double? width;

  /// Fixed button height. Defaults to 54px as per Figma.
  final double height;

  /// Optional icon placed before the label
  final Widget? icon;

  /// Custom border radius override
  final BorderRadius? borderRadius;

  bool get _isClickable => isEnabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppSpacing.roundedLg;
    final backgroundColor = _getBackgroundColor();
    final foregroundColor = _getForegroundColor();
    final border = _getBorder();
    final shadows = _isClickable && variant == DeenButtonVariant.primary
        ? AppSpacing.buttonShadow
        : const <BoxShadow>[];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius,
        border: border,
        boxShadow: shadows,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: _isClickable ? onPressed : null,
          borderRadius: radius,
          splashColor: variant == DeenButtonVariant.primary
              ? AppColors.primaryDark.withValues(alpha: 0.25)
              : AppColors.surfaceLight.withValues(alpha: 0.1),
          highlightColor: AppColors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          foregroundColor,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          icon!,
                          const SizedBox(width: AppSpacing.sm),
                        ],
                        Text(
                          text,
                          style: AppTypography.buttonLarge(
                            color: foregroundColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!_isClickable) {
      return variant == DeenButtonVariant.primary
          ? AppColors.buttonDisabled
          : AppColors.transparent;
    }

    switch (variant) {
      case DeenButtonVariant.primary:
        return AppColors.buttonPrimary;
      case DeenButtonVariant.secondary:
        return AppColors.card;
      case DeenButtonVariant.outline:
      case DeenButtonVariant.ghost:
        return AppColors.transparent;
    }
  }

  Color _getForegroundColor() {
    if (!_isClickable) {
      return AppColors.buttonDisabledText;
    }

    switch (variant) {
      case DeenButtonVariant.primary:
        return AppColors.buttonText;
      case DeenButtonVariant.secondary:
      case DeenButtonVariant.outline:
      case DeenButtonVariant.ghost:
        return AppColors.textPrimary;
    }
  }

  Border? _getBorder() {
    if (variant == DeenButtonVariant.outline) {
      return Border.all(
        color: _isClickable ? AppColors.buttonBorder : AppColors.border,
      );
    }
    return null;
  }
}
