import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/auth/presentation/widgets/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Footer section for the Login screen (Sign Up link, Social auth, Guest).
class LoginFooter extends StatelessWidget {
  const LoginFooter({
    required this.isLoading,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onGuestTap,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onGuestTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: GestureDetector(
            onTap: () => context.push(AppRoutes.signUp),
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodyMedium(
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: AuthStrings.dontHaveAccount),
                  TextSpan(
                    text: AuthStrings.signUp,
                    style: AppTypography.buttonMedium(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxxl),
        SocialAuthButtons(
          isLoading: isLoading,
          onGoogleTap: onGoogleTap,
          onAppleTap: onAppleTap,
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: TextButton(
            onPressed: isLoading ? null : onGuestTap,
            child: Text(
              AuthStrings.continueAsGuest,
              style: AppTypography.bodyMedium(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
