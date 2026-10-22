import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// 4th Screen Action Buttons matching Figma node 1:1008
class OnboardingActionButtons extends StatelessWidget {
  const OnboardingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('actions'),
      mainAxisSize: MainAxisSize.min,
      children: [
        DeenButton(
          text: 'Create Account',
          onPressed: () => context.push(AppRoutes.signUp),
        ),
        const SizedBox(height: AppSpacing.lg),
        DeenButton(
          text: 'Already registered? Log In',
          variant: DeenButtonVariant.secondary,
          onPressed: () => context.push(AppRoutes.login),
        ),
        const SizedBox(height: AppSpacing.md),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return TextButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<AuthBloc>().add(
                        const AuthGuestSignInRequested(),
                      ),
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textSecondary,
                        ),
                      ),
                    )
                  : Text(
                      'Continue as Guest',
                      style: AppTypography.bodyMedium(
                        color: AppColors.textSecondary,
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
