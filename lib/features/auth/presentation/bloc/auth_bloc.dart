import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_otp_handlers.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_social_handlers.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Business logic controller for authentication flows
class AuthBloc extends Bloc<AuthEvent, AuthState>
    with AuthSocialHandlers, AuthOtpHanglers {
  AuthBloc({
    LoginUseCase? loginUseCase,
    RegisterUseCase? registerUseCase,
    VerifyOtpUseCase? verifyOtpUseCase,
    ResendOtpUseCase? resendOtpUseCase,
  }) : loginUseCase =
           loginUseCase ??
           (sl.isRegistered<LoginUseCase>() ? sl<LoginUseCase>() : null),
       registerUseCase =
           registerUseCase ??
           (sl.isRegistered<RegisterUseCase>() ? sl<RegisterUseCase>() : null),
       verifyOtpUseCase =
           verifyOtpUseCase ??
           (sl.isRegistered<VerifyOtpUseCase>()
               ? sl<VerifyOtpUseCase>()
               : null),
       resendOtpUseCase =
           resendOtpUseCase ??
           (sl.isRegistered<ResendOtpUseCase>()
               ? sl<ResendOtpUseCase>()
               : null),
       super(const AuthInitial()) {
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthOtpSubmitted>(onOtpSubmitted);
    on<AuthResendOtpRequested>(onResendOtpRequested);
    on<AuthGuestSignInRequested>(onGuest);
    on<AuthGoogleSignInRequested>(onGoogle);
    on<AuthAppleSignInRequested>(onApple);
  }

  final LoginUseCase? loginUseCase;
  final RegisterUseCase? registerUseCase;
  @override
  final VerifyOtpUseCase? verifyOtpUseCase;
  @override
  final ResendOtpUseCase? resendOtpUseCase;

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    if (loginUseCase != null) {
      final res = await loginUseCase!(
        email: event.email,
        password: event.password,
      );
      res.fold(
        (failure) {
          if (failure is TooManyAttemptsFailure) {
            final mins = (failure.retryAfterSeconds / 60).ceil();
            emit(AuthTooManyAttemptsState(lockoutMinutes: mins));
          } else {
            emit(AuthFailureState(errorMessage: failure.message));
          }
        },
        (data) => emit(AuthSuccess(message: data.detail ?? 'Login successful')),
      );
    } else {
      _fallbackLogin(event, emit);
    }
  }

  void _fallbackLogin(AuthLoginSubmitted e, Emitter<AuthState> emit) {
    if (e.email.contains('@') && e.password.length >= 6) {
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
    if (event.password != event.confirmPassword) {
      emit(const AuthFailureState(errorMessage: 'Passwords do not match'));
      return;
    }
    emit(const AuthLoading());
    if (registerUseCase != null) {
      final res = await registerUseCase!(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        fullName: event.fullName,
      );
      res.fold(
        (failure) => emit(AuthFailureState(errorMessage: failure.message)),
        (_) => emit(AuthRequiresVerification(email: event.email)),
      );
    } else {
      emit(AuthRequiresVerification(email: event.email));
    }
  }
}
