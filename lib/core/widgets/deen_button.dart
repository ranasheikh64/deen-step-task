import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_button_style.dart';
import 'package:flutter/material.dart';

export 'package:deen_app/core/widgets/deen_button_style.dart';

/// Custom button component matching Figma design specifications (node 1:1009).
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

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final DeenButtonVariant variant;
  final double? width;
  final double height;
  final Widget? icon;
  final BorderRadius? borderRadius;

  bool get _isClickable => isEnabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppSpacing.roundedLg;
    final backgroundColor = DeenButtonStyle.getBackgroundColor(
      variant: variant,
      isClickable: _isClickable,
    );
    final foregroundColor = DeenButtonStyle.getForegroundColor(
      variant: variant,
      isClickable: _isClickable,
    );
    final border = DeenButtonStyle.getBorder(
      variant: variant,
      isClickable: _isClickable,
    );
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
}
