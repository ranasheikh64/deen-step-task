import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/utils/validators.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/core/widgets/deen_checkbox.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:deen_app/features/auth/presentation/widgets/social_auth_buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Registration / Create Account Screen matching Figma node 1:760
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_agreedToTerms) {
      DeenSnackBar.showWarning(
        context,
        'Please agree to the Privacy Policy and Terms',
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthRegisterSubmitted(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          agreedToTerms: _agreedToTerms,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRequiresVerification) {
              context.push(AppRoutes.otpVerification, extra: state.email);
            } else if (state is AuthFailureState) {
              DeenSnackBar.showError(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.lg),

                      // 1. Circular Back Button
                      const DeenBackButton(),
                      const SizedBox(height: AppSpacing.xl),

                      // 2. Header (Figma: Poppins Bold 32)
                      Text(
                        'Create Account',
                        style: AppTypography.displayLarge(
                          color: AppColors.textPrimary,
                        ).copyWith(height: 1.1),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Start your consistent steps towards spiritual growth.',
                        style: AppTypography.bodyMedium(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // 3. Full Name Input
                      DeenTextField(
                        controller: _nameController,
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.name,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 4. Email Address Input
                      DeenTextField(
                        controller: _emailController,
                        labelText: 'Email Address',
                        hintText: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.email,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 5. Password Input
                      DeenTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: 'Create a password',
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.password,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 6. Confirm Password Input
                      DeenTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        validator: (val) => AppValidators.confirmPassword(
                          val,
                          _passwordController.text,
                        ),
                        onSubmitted: (_) => _onRegister(),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 7. Terms & Privacy Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: DeenCheckbox(
                              value: _agreedToTerms,
                              onChanged: (val) {
                                setState(() {
                                  _agreedToTerms = val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: AppTypography.bodySmall(
                                  color: AppColors.textSecondary,
                                ).copyWith(height: 1.4),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: AppTypography.buttonSmall(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          context.push(AppRoutes.privacyPolicy),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Terms',
                                    style: AppTypography.buttonSmall(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context.push(
                                        AppRoutes.termsAndConditions,
                                      ),
                                  ),
                                  const TextSpan(text: '.\n'),
                                  TextSpan(
                                    text: 'Click here to Read.',
                                    style: AppTypography.buttonSmall(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          context.push(AppRoutes.privacyPolicy),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // 8. Register Button
                      DeenButton(
                        text: 'Register Account',
                        isLoading: isLoading,
                        onPressed: _onRegister,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 9. Footer Link "Have an account? Log In"
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.pushReplacement(AppRoutes.login);
                            }
                          },
                          child: RichText(
                            text: TextSpan(
                              style: AppTypography.bodyMedium(
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                const TextSpan(text: 'Have an account? '),
                                TextSpan(
                                  text: 'Log In',
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

                      // 10. Social Login Section
                      SocialAuthButtons(
                        label: 'Log In With',
                        onGoogleTap: () => context.read<AuthBloc>().add(
                          const AuthGoogleSignInRequested(),
                        ),
                        onAppleTap: () => context.read<AuthBloc>().add(
                          const AuthAppleSignInRequested(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
