import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/utils/validators.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Form fields and primary action button for the Login screen.
class LoginFormFields extends StatelessWidget {
  const LoginFormFields({
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.isFormFilled,
    required this.onLogin,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool isFormFilled;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xxl),
        DeenTextField(
          controller: emailController,
          labelText: AuthStrings.email,
          hintText: AuthStrings.emailPlaceholder,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: AppValidators.email,
        ),
        const SizedBox(height: AppSpacing.lg),
        DeenTextField(
          controller: passwordController,
          labelText: AuthStrings.password,
          hintText: AuthStrings.passwordHint,
          isPassword: true,
          textInputAction: TextInputAction.done,
          validator: AppValidators.password,
          onSubmitted: (_) => onLogin(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => context.push(AppRoutes.forgotPassword),
            child: Text(
              AuthStrings.forgotPassword,
              style: AppTypography.buttonSmall(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        DeenButton(
          text: AuthStrings.login,
          isLoading: isLoading,
          isEnabled: isFormFilled && !isLoading,
          onPressed: isFormFilled ? onLogin : null,
        ),
      ],
    );
  }
}
