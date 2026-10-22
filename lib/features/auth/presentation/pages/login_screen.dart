import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:deen_app/features/auth/presentation/widgets/login_footer.dart';
import 'package:deen_app/features/auth/presentation/widgets/login_form_fields.dart';
import 'package:deen_app/features/auth/presentation/widgets/login_header.dart';
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
    _authBloc = widget.authBloc ??
        (sl.isRegistered<AuthBloc>() ? sl<AuthBloc>() : AuthBloc());
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _emailController.removeListener(_onFieldChanged);
    _passwordController.removeListener(_onFieldChanged);
    _emailController.dispose();
    _passwordController.dispose();
    if (widget.authBloc == null) _authBloc.close();
    super.dispose();
  }

  void _onLogin() {
    if (!_isFormFilled) return;
    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.add(AuthLoginSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ));
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
                      const LoginHeader(),
                      LoginFormFields(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        isLoading: isLoading,
                        isFormFilled: _isFormFilled,
                        onLogin: _onLogin,
                      ),
                      LoginFooter(
                        isLoading: isLoading,
                        onGoogleTap: () =>
                            _authBloc.add(const AuthGoogleSignInRequested()),
                        onAppleTap: () =>
                            _authBloc.add(const AuthAppleSignInRequested()),
                        onGuestTap: () =>
                            _authBloc.add(const AuthGuestSignInRequested()),
                      ),
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
