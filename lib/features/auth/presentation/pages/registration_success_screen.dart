import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Registration Successful Screen matching Figma node 1:1207.
/// A pure [StatelessWidget] rendering the orbital success checkmark graphic,
/// congratulatory message, and "Go to Home" navigation action.
class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // 1. Orbital Success Graphic (matching Figma node 1:1218)
              SizedBox(
                width: 192,
                height: 192,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Ring (192x192, opacity 0.10)
                    Container(
                      width: 192,
                      height: 192,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.10),
                          width: 4,
                        ),
                      ),
                    ),

                    // Middle Ring (160x160, opacity 0.20)
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.20),
                          width: 4,
                        ),
                      ),
                    ),

                    // Inner Ring (128x128, opacity 0.30)
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.30),
                          width: 4,
                        ),
                      ),
                    ),

                    // Orbiting Decorative Dot 1 (top-left, 8px)
                    Positioned(
                      left: 28.5,
                      top: 19,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.80),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Orbiting Decorative Dot 2 (bottom-right, 12px)
                    Positioned(
                      right: 24,
                      bottom: 32,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.80),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Orbiting Decorative Dot 3 (right, 6px slate)
                    Positioned(
                      right: 16,
                      top: 64,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.slateDot,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Center Glowing Check Circle (80x80)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGlow,
                            blurRadius: 24,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: AppColors.buttonText,
                          size: 38,
                          weight: 800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // 2. Heading
              Text(
                'Registration Successful',
                textAlign: TextAlign.center,
                style: AppTypography.headlineLarge(color: AppColors.textPrimary)
                    .copyWith(letterSpacing: 0.3, height: 1.2),
              ),
              const SizedBox(height: AppSpacing.sm),

              // 3. Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  'Your account has been created successfully. Welcome to Deen.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textSecondary,
                  ).copyWith(height: 1.4),
                ),
              ),

              const Spacer(flex: 3),

              // 4. Go to Home Button
              DeenButton(
                text: 'Go to Home',
                onPressed: () => context.go(AppRoutes.dashboard),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
