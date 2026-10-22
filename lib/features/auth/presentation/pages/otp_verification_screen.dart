import 'dart:async';

import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/core/widgets/deen_back_button.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

/// Verify Email OTP Screen matching Figma node 1:807.
/// Uses [Pinput] for the 4-digit code entry with dynamic states:
/// - Inactive / active focus states
/// - Error state with remaining attempts
/// - Disabled / enabled Verify button based on 4-digit completion
/// - 30-second resend countdown timer
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
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  late final AuthBloc _authBloc;

  Timer? _resendTimer;
  int _secondsRemaining = 30;
  bool _hasError = false;
  int _remainingAttempts = 3;

  @override
  void initState() {
    super.initState();
    _authBloc = widget.authBloc ?? AuthBloc();
    _startResendTimer();
    _pinController.addListener(_onPinChanged);
  }

  void _onPinChanged() {
    if (_hasError) {
      setState(() {
        _hasError = false;
      });
    } else {
      setState(() {});
    }
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _secondsRemaining = 30;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onResendCode() {
    if (_secondsRemaining > 0) return;
    _authBloc.add(AuthResendOtpRequested(email: widget.email));
    _startResendTimer();
    DeenSnackBar.showSuccess(context, 'Verification code resent');
  }

  void _onVerify() {
    final pin = _pinController.text.trim();
    if (pin.length != 4) return;

    _authBloc.add(AuthOtpSubmitted(email: widget.email, otp: pin));
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _pinController.removeListener(_onPinChanged);
    _pinController.dispose();
    _focusNode.dispose();
    if (widget.authBloc == null) {
      _authBloc.close();
    }
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
            final isPinComplete = _pinController.text.trim().length == 4;

            // Pinput Themes matching Figma node 1:807
            final defaultPinTheme = PinTheme(
              width: 70,
              height: 74,
              textStyle: AppTypography.headlineLarge(
                color: AppColors.textPrimary,
              ).copyWith(fontWeight: FontWeight.w700, fontSize: 24),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hasError ? AppColors.error : AppColors.inputBorder,
                  width: _hasError ? 1.5 : 1,
                ),
              ),
            );

            final focusedPinTheme = defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hasError ? AppColors.error : AppColors.primary,
                  width: 1.5,
                ),
              ),
            );

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.lg),

                    // 1. Back button
                    const DeenBackButton(),
                    const SizedBox(height: AppSpacing.xl),

                    // 2. Title & Subtitle with highlighted email
                    Text(
                      'Verify Email',
                      style: AppTypography.displayLarge(
                        color: AppColors.textPrimary,
                      ).copyWith(height: 1.1),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text.rich(
                      TextSpan(
                        style: AppTypography.bodyMedium(
                          color: AppColors.textSecondary,
                        ).copyWith(height: 1.4),
                        children: [
                          const TextSpan(
                            text: "We've sent a 4-digit verification code to\n",
                          ),
                          TextSpan(
                            text: widget.email,
                            style: AppTypography.bodyMedium(
                              color: AppColors.primary,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),

                    // 3. 4-Digit Pinput Field
                    Center(
                      child: Material(
                        type: MaterialType.transparency,
                        child: Pinput(
                          length: 4,
                          controller: _pinController,
                          focusNode: _focusNode,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: defaultPinTheme,
                          cursor: Container(
                            width: 2,
                            height: 28,
                            color: AppColors.textPrimary,
                          ),
                          onCompleted: (_) => _onVerify(),
                        ),
                      ),
                    ),

                    // 4. Incorrect Code error state
                    if (_hasError) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text.rich(
                        TextSpan(
                          style: AppTypography.bodySmall(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Incorrect Code : ',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            TextSpan(
                              text: '$_remainingAttempts attempts remaining.',
                              style: AppTypography.bodySmall(
                                color: AppColors.primary,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppSpacing.xxl),

                    // 5. Verify Button (Disabled until all 4 digits entered)
                    DeenButton(
                      text: 'Verify',
                      isLoading: isLoading,
                      isEnabled: isPinComplete,
                      onPressed: isPinComplete ? _onVerify : null,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // 6. Resend Code Countdown Link
                    Center(
                      child: Text.rich(
                        TextSpan(
                          style: AppTypography.bodyMedium(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(text: "Didn't receive code? "),
                            if (_secondsRemaining > 0)
                              TextSpan(
                                text:
                                    'Resend in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                style: AppTypography.buttonMedium(
                                  color: AppColors.primary,
                                ),
                              )
                            else
                              TextSpan(
                                text: 'Resend Code',
                                style: AppTypography.buttonMedium(
                                  color: AppColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onResendCode,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
