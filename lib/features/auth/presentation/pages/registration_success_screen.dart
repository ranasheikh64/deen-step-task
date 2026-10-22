import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/constants/asset_paths.dart';
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

              Image.asset(AssetPaths.successImage, height: 200, width: 200),

              const SizedBox(height: AppSpacing.xxxl),

              // 2. Heading
              Text(
                AuthStrings.registrationSuccess,
                textAlign: TextAlign.center,
                style: AppTypography.headlineLarge(color: AppColors.textPrimary)
                    .copyWith(letterSpacing: 0.3, height: 1.2),
              ),
              const SizedBox(height: AppSpacing.sm),

              // 3. Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  AuthStrings.registrationSuccessMessage,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textSecondary,
                  ).copyWith(height: 1.4),
                ),
              ),

              const Spacer(flex: 1),

              // 4. Go to Home Button
              DeenButton(
                text: AuthStrings.goToHome,
                onPressed: () => context.go(AppRoutes.dashboard),
              ),
              const SizedBox(height: AppSpacing.xxl),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
