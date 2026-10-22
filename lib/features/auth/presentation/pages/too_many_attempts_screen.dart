import 'dart:async';
import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:deen_app/features/auth/presentation/widgets/lockout_support_footer.dart';
import 'package:deen_app/features/auth/presentation/widgets/lockout_timer_card.dart';
import 'package:flutter/material.dart';

/// Too Many Attempts Screen matching Figma node 1:1232.
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
        setState(() => _remainingSeconds--);
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
              const Align(
                alignment: Alignment.centerLeft,
                child: DeenBackButton(),
              ),
              const Spacer(),
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
              LockoutTimerCard(formattedTime: _formattedTime),
              const SizedBox(height: AppSpacing.xxxl),
              Text(
                AuthStrings.tooManyAttempts,
                textAlign: TextAlign.center,
                style: AppTypography.headlineLarge(color: AppColors.textPrimary)
                    .copyWith(height: 1.2),
              ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  AuthStrings.lockoutDescription,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textSecondary,
                  ).copyWith(height: 1.4),
                ),
              ),
              const Spacer(flex: 2),
              const LockoutSupportFooter(),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
