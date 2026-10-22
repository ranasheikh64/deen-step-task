import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/utils/validators.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/core/widgets/deen_text_field.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:deen_app/features/auth/presentation/widgets/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Login Screen matching Figma node 1:886
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.authBloc});

  final AuthBloc? authBloc;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthBloc _authBloc;

  bool get _isFormFilled =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _authBloc = widget.authBloc ?? (sl.isRegistered<AuthBloc>() ? sl<AuthBloc>() : AuthBloc());
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.removeListener(_onFieldChanged);
    _passwordController.removeListener(_onFieldChanged);
    _emailController.dispose();
    _passwordController.dispose();
    if (widget.authBloc == null) {
      _authBloc.close();
    }
    super.dispose();
  }

  void _onLogin() {
    if (!_isFormFilled) return;

    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.add(
        AuthLoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authBloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.go(AppRoutes.dashboard);
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
                        'Welcome Back',
                        style: AppTypography.displayLarge(
                          color: AppColors.textPrimary,
                        ).copyWith(height: 1.1),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Enter your details to access your Deen-step habits.',
                        style: AppTypography.bodyMedium(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // 3. Email Input
                      DeenTextField(
                        controller: _emailController,
                        labelText: 'Email Address',
                        hintText: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: AppValidators.email,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 4. Password Input
                      DeenTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        validator: AppValidators.password,
                        onSubmitted: (_) => _onLogin(),
                      ),

                      // 5. Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              context.push(AppRoutes.forgotPassword),
                          child: Text(
                            'Forgot password?',
                            style: AppTypography.buttonSmall(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // 6. Log In Button
                      DeenButton(
                        text: 'Log In',
                        isLoading: isLoading,
                        isEnabled: _isFormFilled && !isLoading,
                        onPressed: _isFormFilled ? _onLogin : null,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // 7. Footer "Dont have an account? Sign Up"
                      Center(
                        child: GestureDetector(
                          onTap: () => context.push(AppRoutes.signUp),
                          child: RichText(
                            text: TextSpan(
                              style: AppTypography.bodyMedium(
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                const TextSpan(text: 'Dont have an account? '),
                                TextSpan(
                                  text: 'Sign Up',
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

                      // 8. Social Login Section
                      SocialAuthButtons(
                        label: 'Log In With',
                        isLoading: isLoading,
                        onGoogleTap: () =>
                            _authBloc.add(const AuthGoogleSignInRequested()),
                        onAppleTap: () =>
                            _authBloc.add(const AuthAppleSignInRequested()),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Center(
                        child: TextButton(
                          onPressed: isLoading
                              ? null
                              : () => _authBloc.add(
                                    const AuthGuestSignInRequested(),
                                  ),
                          child: Text(
                            'Continue as Guest',
                            style: AppTypography.bodyMedium(
                              color: AppColors.textSecondary,
                            ),
                          ),
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
