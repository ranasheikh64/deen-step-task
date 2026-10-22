import 'dart:async';

import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Too Many Attempts Screen matching Figma node 1:1232.
/// Displays security lockout timer with countdown, lock graphic, and support assistance.
class TooManyAttemptsScreen extends StatefulWidget {
  const TooManyAttemptsScreen({
    super.key,
    this.initialSeconds = 1778, // 29:38 matching Figma spec
  });

  final int initialSeconds;

  @override
  State<TooManyAttemptsScreen> createState() => _TooManyAttemptsScreenState();
}

class _TooManyAttemptsScreenState extends State<TooManyAttemptsScreen> {
  late int _remainingSeconds;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),

              // 1. Back button
              const Align(
                alignment: Alignment.centerLeft,
                child: DeenBackButton(),
              ),

              const Spacer(),

              // 2. Lock Icon Graphic
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, width: 2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock_rounded,
                    size: 44,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // 3. Time Remaining Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppSpacing.roundedLg,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 22,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _formattedTime,
                      style:
                          AppTypography.displayLarge(color: AppColors.primary)
                              .copyWith(
                                fontSize: 44,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'TIME REMAINING',
                      style:
                          AppTypography.bodySmall(color: AppColors.textTertiary)
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                fontSize: 11,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // 4. Heading & Description
              Text(
                'Too Many Attempts',
                textAlign: TextAlign.center,
                style: AppTypography.headlineLarge(color: AppColors.textPrimary)
                    .copyWith(height: 1.2),
              ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  "We've detected too many incorrect verification attempts. For your account's security, further attempts have been temporarily blocked.",
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textSecondary,
                  ).copyWith(height: 1.4),
                ),
              ),

              const Spacer(flex: 2),

              // 5. Need Help / Contact Support footer
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: AppColors.error,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text.rich(
                      TextSpan(
                        style: AppTypography.bodySmall(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Need help? '),
                          TextSpan(
                            text: 'Contact Support',
                            style: AppTypography.buttonSmall(
                              color: AppColors.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => DeenSnackBar.showInfo(
                                context,
                                'Support contact: support@deenstep.com',
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
