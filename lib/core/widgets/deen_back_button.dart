import 'package:deen_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Circular 40x40 back button component matching Figma design
class DeenBackButton extends StatelessWidget {
  const DeenBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap:
              onPressed ??
              () {
                if (context.canPop()) {
                  context.pop();
                }
              },
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
