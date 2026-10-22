import 'package:deen_app/core/services/auth/social_login_service.dart';
import 'package:deen_app/features/auth/domain/usecases/guest_login_usecase.dart';
import 'package:deen_app/features/auth/domain/usecases/social_auth_usecase.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin providing guest and social authentication handlers
mixin AuthSocialHandlers {
  SocialAuthUseCase? get socialAuthUseCase;
  GuestLoginUseCase? get guestLoginUseCase;

  Future<void> onGuest(
    AuthGuestSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    if (guestLoginUseCase == null) {
      emit(const AuthSuccess(message: 'Logged in as Guest'));
      return;
    }
    final res = await guestLoginUseCase!();
    res.fold(
      (failure) => emit(AuthFailureState(errorMessage: failure.message)),
      (data) => emit(AuthSuccess(message: data.detail ?? 'Logged in as Guest')),
    );
  }

  Future<void> onGoogle(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) => _performSocialAuth('google', googleLoginService, emit);

  Future<void> onApple(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) => _performSocialAuth('apple', appleLoginService, emit);

  Future<void> _performSocialAuth(
    String provider,
    Future<SocialLoginResult> Function() loginFn,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final result = await loginFn();
      if (socialAuthUseCase == null) {
        emit(AuthSuccess(message: '$provider sign-in successful'));
        return;
      }
      final res = await socialAuthUseCase!(
        idToken: result.idToken,
        provider: provider,
      );
      res.fold(
        (failure) => emit(AuthFailureState(errorMessage: failure.message)),
        (data) => emit(AuthSuccess(message: data.detail ?? 'Login successful')),
      );
    } on SocialAuthCanceledException {
      emit(const AuthInitial());
    } on Object catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      if (msg.toLowerCase().contains('cancel')) {
        emit(const AuthInitial());
      } else {
        emit(AuthFailureState(errorMessage: msg));
      }
    }
  }
}
