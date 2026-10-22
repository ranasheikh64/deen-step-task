import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin handling OTP verification, resend, and failed attempts lockout
mixin AuthOtpHanglers {
  VerifyOtpUseCase? get verifyOtpUseCase;
  ResendOtpUseCase? get resendOtpUseCase;

  int remainingAttempts = 3;

  Future<void> onOtpSubmitted(
    AuthOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    if (verifyOtpUseCase != null) {
      final res = await verifyOtpUseCase!(email: event.email, otp: event.otp);
      res.fold((failure) => handleOtpFailure(failure, emit), (data) {
        remainingAttempts = 3;
        emit(
          AuthVerificationSuccess(
            message: data.detail ?? 'Email verified successfully',
          ),
        );
      });
    } else {
      await _fallbackOtp(event.otp, emit);
    }
  }

  Future<void> _fallbackOtp(String otp, Emitter<AuthState> emit) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (otp == '0000') {
      remainingAttempts--;
      if (remainingAttempts <= 0) {
        emit(const AuthTooManyAttemptsState(lockoutMinutes: 30));
      } else {
        emit(
          AuthOtpFailureState(
            errorMessage: 'Incorrect Code',
            remainingAttempts: remainingAttempts,
          ),
        );
      }
    } else {
      remainingAttempts = 3;
      emit(
        const AuthVerificationSuccess(message: 'Email verified successfully'),
      );
    }
  }

  void handleOtpFailure(Failure failure, Emitter<AuthState> emit) {
    if (failure is TooManyAttemptsFailure) {
      final mins = (failure.retryAfterSeconds / 60).ceil();
      emit(AuthTooManyAttemptsState(lockoutMinutes: mins));
      return;
    }
    remainingAttempts--;
    if (remainingAttempts <= 0) {
      emit(const AuthTooManyAttemptsState(lockoutMinutes: 30));
    } else {
      emit(
        AuthOtpFailureState(
          errorMessage: failure.message,
          remainingAttempts: remainingAttempts,
        ),
      );
    }
  }

  Future<void> onResendOtpRequested(
    AuthResendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    if (resendOtpUseCase != null) {
      final res = await resendOtpUseCase!(email: event.email);
      res.fold(
        (failure) {
          if (failure is TooManyAttemptsFailure) {
            final mins = (failure.retryAfterSeconds / 60).ceil();
            emit(AuthTooManyAttemptsState(lockoutMinutes: mins));
          } else {
            emit(AuthFailureState(errorMessage: failure.message));
          }
        },
        (_) {
          remainingAttempts = 3;
          emit(AuthRequiresVerification(email: event.email));
        },
      );
    } else {
      remainingAttempts = 3;
      emit(AuthRequiresVerification(email: event.email));
    }
  }
}
