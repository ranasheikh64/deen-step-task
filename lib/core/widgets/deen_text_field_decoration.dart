import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Decoration and styling helpers for DeenTextField.
class DeenTextFieldDecoration {
  const DeenTextFieldDecoration._();

  static InputDecoration buildInputDecoration({
    required String? hintText,
    required bool enabled,
    required bool hasError,
    required bool isPassword,
    required bool obscured,
    required VoidCallback? onToggleObscure,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: enabled
          ? AppColors.inputBackground
          : AppColors.inputBackground.withValues(alpha: 0.6),
      hintText: hintText,
      hintStyle: AppTypography.inputHint(),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 18,
      ),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              child: prefixIcon,
            )
          : null,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 44,
        minHeight: 24,
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                obscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textTertiary,
                size: 20,
              ),
              onPressed: enabled ? onToggleObscure : null,
            )
          : suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: suffixIcon,
                )
              : null,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 44,
        minHeight: 24,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedMd,
        borderSide: BorderSide(
          color: hasError ? AppColors.error : AppColors.inputBorder,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedMd,
        borderSide: BorderSide(
          color: AppColors.inputBorder.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.roundedMd,
        borderSide: BorderSide(
          color: hasError ? AppColors.error : AppColors.inputFocusedBorder,
          width: 1.5,
        ),
      ),
    );
  }

  static Widget buildError(String errorText) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xs,
        left: AppSpacing.xs,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            size: 14,
            color: AppColors.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              errorText,
              style: AppTypography.inputError(),
            ),
          ),
        ],
      ),
    );
  }
}
