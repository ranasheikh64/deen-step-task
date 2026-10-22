import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:flutter/material.dart';

/// FormField presentation body for [DeenTextField].
class DeenTextFieldView extends StatelessWidget {
  const DeenTextFieldView({
    required this.config,
    required this.effectiveController,
    required this.effectiveFocusNode,
    required this.obscured,
    required this.onToggleObscure,
    super.key,
  });

  final DeenTextField config;
  final TextEditingController effectiveController;
  final FocusNode effectiveFocusNode;
  final bool obscured;
  final VoidCallback onToggleObscure;

  @override
  Widget build(BuildContext context) {
    final hasFocus = effectiveFocusNode.hasFocus;
    final hasText = effectiveController.text.isNotEmpty;
    final showLabel = config.labelText != null &&
        (!config.dynamicLabel || hasFocus || hasText);
    final effectiveHint = showLabel
        ? (config.hintText ?? config.labelText)
        : (config.labelText ?? config.hintText);

    return FormField<String>(
      initialValue: config.initialValue ?? effectiveController.text,
      validator: config.validator,
      autovalidateMode: config.autovalidateMode,
      builder: (field) {
        final hasError = field.hasError && field.errorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLabel)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  config.labelText!,
                  style: AppTypography.inputLabel().copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            TextField(
              controller: effectiveController,
              onChanged: (val) {
                field.didChange(val);
                config.onChanged?.call(val);
              },
              onSubmitted: config.onSubmitted,
              enabled: config.enabled,
              readOnly: config.readOnly,
              obscureText: obscured,
              keyboardType: config.keyboardType,
              textInputAction: config.textInputAction,
              focusNode: effectiveFocusNode,
              maxLines: config.maxLines,
              autofocus: config.autofocus,
              inputFormatters: config.inputFormatters,
              style: config.enabled
                  ? AppTypography.inputText()
                  : AppTypography.inputText(color: AppColors.textTertiary),
              cursorColor: AppColors.primary,
              decoration: DeenTextFieldDecoration.buildInputDecoration(
                hintText: effectiveHint,
                enabled: config.enabled,
                hasError: hasError,
                isPassword: config.isPassword,
                obscured: obscured,
                onToggleObscure: onToggleObscure,
                prefixIcon: config.prefixIcon,
                suffixIcon: config.suffixIcon,
              ),
            ),
            if (hasError) DeenTextFieldDecoration.buildError(field.errorText!),
          ],
        );
      },
    );
  }
}
