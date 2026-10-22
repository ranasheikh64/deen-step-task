import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom TextField component matching Figma design specifications (node 1:859).
/// Features dynamic label visibility: the label above the field is displayed
/// ONLY when the field is active (has focus or contains text).
/// Otherwise, clean hint text is displayed inside the input.
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
    this.dynamicLabel = true,
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
  final bool dynamicLabel;

  @override
  State<DeenTextField> createState() => _DeenTextFieldState();
}

class _DeenTextFieldState extends State<DeenTextField> {
  late bool _obscured;
  FocusNode? _internalFocusNode;
  TextEditingController? _internalController;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  TextEditingController get _effectiveController =>
      widget.controller ?? (_internalController ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _obscured = widget.isPassword || widget.obscureText;
    _effectiveFocusNode.addListener(_onFocusOrTextChanged);
    _effectiveController.addListener(_onFocusOrTextChanged);
  }

  @override
  void didUpdateWidget(DeenTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)?.removeListener(
        _onFocusOrTextChanged,
      );
      _effectiveFocusNode.addListener(_onFocusOrTextChanged);
    }
    if (oldWidget.controller != widget.controller) {
      (oldWidget.controller ?? _internalController)?.removeListener(
        _onFocusOrTextChanged,
      );
      _effectiveController.addListener(_onFocusOrTextChanged);
    }
  }

  void _onFocusOrTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusOrTextChanged);
    _effectiveController.removeListener(_onFocusOrTextChanged);
    _internalFocusNode?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  void _toggleObscurity() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = _effectiveFocusNode.hasFocus;
    final hasText = _effectiveController.text.isNotEmpty;
    final showLabel =
        widget.labelText != null &&
        (!widget.dynamicLabel || hasFocus || hasText);
    final effectiveHint = showLabel
        ? (widget.hintText ?? widget.labelText)
        : (widget.labelText ?? widget.hintText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dynamic Label: Only visible when active (focused or has text)
        if (showLabel) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              widget.labelText!,
              style: AppTypography.inputLabel().copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
        TextFormField(
          controller: _effectiveController,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          focusNode: _effectiveFocusNode,
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
            hintText: effectiveHint,
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
