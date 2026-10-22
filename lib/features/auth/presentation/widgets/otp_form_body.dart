import 'dart:async';
import 'package:deen_app/core/constants/app_strings.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/widgets/deen_button.dart';
import 'package:deen_app/core/widgets/deen_snackbar.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/widgets/otp_header.dart';
import 'package:deen_app/features/auth/presentation/widgets/otp_incorrect_code_widget.dart';
import 'package:deen_app/features/auth/presentation/widgets/otp_pin_theme.dart';
import 'package:deen_app/features/auth/presentation/widgets/otp_resend_section.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

/// Form body managing timer, code input, and actions for OTP verification.
class OtpFormBody extends StatefulWidget {
  const OtpFormBody({
    required this.email,
    required this.authBloc,
    required this.isLoading,
    required this.hasError,
    required this.remainingAttempts,
    super.key,
  });

  final String email;
  final AuthBloc authBloc;
  final bool isLoading;
  final bool hasError;
  final int remainingAttempts;

  @override
  State<OtpFormBody> createState() => _OtpFormBodyState();
}

class _OtpFormBodyState extends State<OtpFormBody> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _resendTimer;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    _pinController.addListener(() => setState(() {}));
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _secondsRemaining = 30);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        t.cancel();
      }
    });
  }

  void _onResendCode() {
    if (_secondsRemaining > 0) return;
    widget.authBloc.add(AuthResendOtpRequested(email: widget.email));
    _startResendTimer();
    DeenSnackBar.showSuccess(context, AuthStrings.codeResentSuccess);
  }

  void _onVerify() {
    final pin = _pinController.text.trim();
    if (pin.length == 4) {
      widget.authBloc.add(AuthOtpSubmitted(email: widget.email, otp: pin));
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPinComplete = _pinController.text.trim().length == 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OtpHeader(email: widget.email),
        Center(
          child: Pinput(
            length: 4,
            controller: _pinController,
            focusNode: _focusNode,
            defaultPinTheme:
                OtpPinThemes.defaultTheme(hasError: widget.hasError),
            focusedPinTheme:
                OtpPinThemes.focusedTheme(hasError: widget.hasError),
            onCompleted: (_) => _onVerify(),
          ),
        ),
        if (widget.hasError)
          OtpIncorrectCodeWidget(remainingAttempts: widget.remainingAttempts),
        const SizedBox(height: AppSpacing.xxl),
        DeenButton(
          text: AuthStrings.verify,
          isLoading: widget.isLoading,
          isEnabled: isPinComplete,
          onPressed: isPinComplete ? _onVerify : null,
        ),
        const SizedBox(height: AppSpacing.xl),
        OtpResendSection(
          secondsRemaining: _secondsRemaining,
          onResend: _onResendCode,
        ),
      ],
    );
  }
}
