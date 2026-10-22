import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/utils/validators.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:flutter/material.dart';

/// Input text fields for the Register screen.
class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xxl),
        DeenTextField(
          controller: nameController,
          labelText: AuthStrings.fullName,
          hintText: AuthStrings.fullNameHint,
          textInputAction: TextInputAction.next,
          validator: AppValidators.name,
        ),
        const SizedBox(height: AppSpacing.lg),
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
          hintText: AuthStrings.passwordCreateHint,
          isPassword: true,
          textInputAction: TextInputAction.next,
          validator: AppValidators.registrationPassword,
        ),
        const SizedBox(height: AppSpacing.lg),
        DeenTextField(
          controller: confirmPasswordController,
          labelText: AuthStrings.confirmPassword,
          hintText: AuthStrings.confirmPasswordHint,
          isPassword: true,
          textInputAction: TextInputAction.done,
          validator: (val) => AppValidators.confirmPassword(
            val,
            passwordController.text,
          ),
          onSubmitted: (_) => onRegister(),
        ),
      ],
    );
  }
}
