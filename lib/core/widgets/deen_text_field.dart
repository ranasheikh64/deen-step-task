import 'package:deen_app/core/widgets/deen_text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'package:deen_app/core/widgets/deen_text_field_decoration.dart';
export 'package:deen_app/core/widgets/deen_text_field_view.dart';

/// Custom TextField component matching Figma design specifications (node 1:859).
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
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
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
  final AutovalidateMode? autovalidateMode;

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
    _effectiveFocusNode.addListener(_onStateChanged);
    _effectiveController.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onStateChanged);
    _effectiveController.removeListener(_onStateChanged);
    _internalFocusNode?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DeenTextFieldView(
      config: widget,
      effectiveController: _effectiveController,
      effectiveFocusNode: _effectiveFocusNode,
      obscured: _obscured,
      onToggleObscure: () => setState(() => _obscured = !_obscured),
    );
  }
}
