import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Modal dialog requesting device location access matching Figma node 1:1206
class EnableLocationDialog extends StatelessWidget {
  const EnableLocationDialog({required this.onTurnOnLocation, super.key});

  final VoidCallback onTurnOnLocation;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onTurnOnLocation,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => EnableLocationDialog(
        onTurnOnLocation: () {
          Navigator.of(context).pop();
          onTurnOnLocation();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1612),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF2C2E2D)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Badge Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2C2E2D)),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // 2. Heading
            Text(
              HomeStrings.enableLocation,
              textAlign: TextAlign.center,
              style: AppTypography.headlineMedium(color: const Color(0xFFF9FAFB))
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: AppSpacing.md),

            // 3. Body Text
            Text.rich(
              TextSpan(
                style: AppTypography.bodySmall(
                  color: const Color(0xFF9CA3AF),
                ).copyWith(fontSize: 14, height: 1.4),
                children: const [
                  TextSpan(
                    text: 'To provide you with highly accurate\n'
                        'prayer times and the correct Qibla\ndirection, ',
                  ),
                  TextSpan(
                    text: 'We need to access',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: " your\ndevice's location."),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // 4. Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onTurnOnLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: const Color(0xFF111827),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(HomeStrings.turnOnLocation, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
