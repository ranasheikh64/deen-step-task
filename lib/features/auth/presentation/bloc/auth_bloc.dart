import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Business logic controller for login and registration flows
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthGuestSignInRequested>(_onGuestSignInRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthAppleSignInRequested>(_onAppleSignInRequested);
    on<AuthOtpSubmitted>(_onOtpSubmitted);
    on<AuthResendOtpRequested>(_onResendOtpRequested);
  }

  int _remainingAttempts = 3;

  Future<void> _onOtpSubmitted(
    AuthOtpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // '0000' triggers incorrect OTP to demonstrate error state and attempt decrementing
    if (event.otp == '0000') {
      _remainingAttempts--;
      if (_remainingAttempts <= 0) {
        emit(const AuthTooManyAttemptsState(lockoutMinutes: 30));
      } else {
        emit(
          AuthOtpFailureState(
            errorMessage: 'Incorrect Code',
            remainingAttempts: _remainingAttempts,
          ),
        );
      }
    } else {
      _remainingAttempts = 3;
      emit(
        const AuthVerificationSuccess(message: 'Email verified successfully'),
      );
    }
  }

  Future<void> _onResendOtpRequested(
    AuthResendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _remainingAttempts = 3;
    emit(AuthRequiresVerification(email: event.email));
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (event.email.contains('@') && event.password.length >= 6) {
      emit(const AuthSuccess(message: 'Login successful'));
    } else {
      emit(const AuthFailureState(errorMessage: 'Invalid email or password'));
    }
  }

  Future<void> _onRegisterSubmitted(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (!event.agreedToTerms) {
      emit(
        const AuthFailureState(
          errorMessage: 'You must agree to the Terms & Privacy Policy',
        ),
      );
      return;
    }

    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (event.password != event.confirmPassword) {
      emit(const AuthFailureState(errorMessage: 'Passwords do not match'));
      return;
    }

    emit(AuthRequiresVerification(email: event.email));
  }

  Future<void> _onGuestSignInRequested(
    AuthGuestSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 400));
    emit(const AuthSuccess(message: 'Logged in as Guest'));
  }

  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    emit(const AuthSuccess(message: 'Google Sign-in successful'));
  }

  Future<void> _onAppleSignInRequested(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    emit(const AuthSuccess(message: 'Apple Sign-in successful'));
  }
}
