import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:deen_app/features/auth/presentation/widgets/register_form_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Registration / Create Account Screen matching Figma node 1:760
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.authBloc});

  final AuthBloc? authBloc;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = widget.authBloc ??
        (sl.isRegistered<AuthBloc>() ? sl<AuthBloc>() : AuthBloc());
  }

  @override
  void dispose() {
    if (widget.authBloc == null) _authBloc.close();
    super.dispose();
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
            } else if (state is AuthRequiresVerification) {
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
                child: RegisterFormContent(
                  authBloc: _authBloc,
                  isLoading: isLoading,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
