import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:deen_app/features/auth/presentation/widgets/otp_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Verify Email OTP Screen matching Figma node 1:807.
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    this.email = 'user@example.com',
    this.authBloc,
  });

  final String email;
  final AuthBloc? authBloc;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final AuthBloc _authBloc;
  bool _hasError = false;
  int _remainingAttempts = 3;

  @override
  void initState() {
    super.initState();
    _authBloc = widget.authBloc ?? AuthBloc();
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
            if (state is AuthVerificationSuccess) {
              context.go(AppRoutes.registrationSuccess);
            } else if (state is AuthOtpFailureState) {
              setState(() {
                _hasError = true;
                _remainingAttempts = state.remainingAttempts;
              });
            } else if (state is AuthTooManyAttemptsState) {
              context.go(AppRoutes.tooManyAttempts);
            } else if (state is AuthFailureState) {
              DeenSnackBar.showError(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: OtpFormBody(
                  email: widget.email,
                  authBloc: _authBloc,
                  isLoading: isLoading,
                  hasError: _hasError,
                  remainingAttempts: _remainingAttempts,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
