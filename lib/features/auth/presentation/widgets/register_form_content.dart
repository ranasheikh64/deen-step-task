import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/widgets/register_footer.dart';
import 'package:deen_app/features/auth/presentation/widgets/register_form_fields.dart';
import 'package:deen_app/features/auth/presentation/widgets/register_header.dart';
import 'package:deen_app/features/auth/presentation/widgets/register_terms_checkbox.dart';
import 'package:flutter/material.dart';

/// Form body managing controllers and submission for Register screen.
class RegisterFormContent extends StatefulWidget {
  const RegisterFormContent({
    required this.authBloc,
    required this.isLoading,
    super.key,
  });

  final AuthBloc authBloc;
  final bool isLoading;

  @override
  State<RegisterFormContent> createState() => _RegisterFormContentState();
}

class _RegisterFormContentState extends State<RegisterFormContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  bool get _isFormFilled =>
      _nameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty &&
      _agreedToTerms;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _confirmPasswordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _nameController.removeListener(_onFieldChanged);
    _emailController.removeListener(_onFieldChanged);
    _passwordController.removeListener(_onFieldChanged);
    _confirmPasswordController.removeListener(_onFieldChanged);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (!_isFormFilled) return;
    if (_formKey.currentState?.validate() ?? false) {
      widget.authBloc.add(AuthRegisterSubmitted(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        agreedToTerms: _agreedToTerms,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RegisterHeader(),
          RegisterFormFields(
            nameController: _nameController,
            emailController: _emailController,
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            onRegister: _onRegister,
          ),
          const SizedBox(height: AppSpacing.lg),
          RegisterTermsCheckbox(
            value: _agreedToTerms,
            onChanged: (val) => setState(() => _agreedToTerms = val),
          ),
          const SizedBox(height: AppSpacing.xl),
          DeenButton(
            text: AuthStrings.registerAccount,
            isLoading: widget.isLoading,
            isEnabled: _isFormFilled && !widget.isLoading,
            onPressed: _isFormFilled ? _onRegister : null,
          ),
          RegisterFooter(
            isLoading: widget.isLoading,
            onGoogleTap: () =>
                widget.authBloc.add(const AuthGoogleSignInRequested()),
            onAppleTap: () =>
                widget.authBloc.add(const AuthAppleSignInRequested()),
            onGuestTap: () =>
                widget.authBloc.add(const AuthGuestSignInRequested()),
          ),
        ],
      ),
    );
  }
}
