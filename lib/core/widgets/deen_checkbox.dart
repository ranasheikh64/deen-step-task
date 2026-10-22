import 'package:deen_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Custom Checkbox matching Figma specifications (node 1:780).
/// Renders a crisp 18x18 white box with rounded corners (4px)
/// and a dark checkmark when checked.
class DeenCheckbox extends StatelessWidget {
  const DeenCheckbox({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: AppColors.checkboxWhite,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: value
            ? const Icon(
                Icons.check,
                size: 14,
                color: AppColors.checkboxCheckmark,
              )
            : null,
      ),
    );
  }
}
