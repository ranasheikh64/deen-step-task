import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom TextField component matching Figma design specifications (node 1:859).
/// Supports enabled/disabled states, validators, prefix/suffix icons,
/// and password visibility toggling without any hardcoded colors or styles.
class DeenTextField extends StatefulWidget {
  const DeenTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isPassword = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.maxLines = 1,
    this.autofocus = false,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int maxLines;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DeenTextField> createState() => _DeenTextFieldState();
}

class _DeenTextFieldState extends State<DeenTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.isPassword || widget.obscureText;
  }

  void _toggleObscurity() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(widget.labelText!, style: AppTypography.inputLabel()),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          controller: widget.controller,
          initialValue: widget.initialValue,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          maxLines: widget.maxLines,
          autofocus: widget.autofocus,
          inputFormatters: widget.inputFormatters,
          style: widget.enabled
              ? AppTypography.inputText()
              : AppTypography.inputText(color: AppColors.textTertiary),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: widget.enabled
                ? AppColors.inputBackground
                : AppColors.inputBackground.withValues(alpha: 0.6),
            hintText: widget.hintText,
            hintStyle: AppTypography.inputHint(),
            errorStyle: AppTypography.inputError(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 18,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 24,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    onPressed: widget.enabled ? _toggleObscurity : null,
                  )
                : widget.suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: widget.suffixIcon,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 24,
            ),
            // Default border matching Figma (slate/850, #2C2E2D, 12px radius)
            enabledBorder: const OutlineInputBorder(
              borderRadius: AppSpacing.roundedMd,
              borderSide: BorderSide(color: AppColors.inputBorder),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.roundedMd,
              borderSide: BorderSide(
                color: AppColors.inputBorder.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: AppSpacing.roundedMd,
              borderSide: BorderSide(
                color: AppColors.inputFocusedBorder,
                width: 1.5,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: AppSpacing.roundedMd,
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: AppSpacing.roundedMd,
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
