import 'package:deen_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:deen_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin providing guest and social authentication handlers
mixin AuthSocialHandlers {
  Future<void> onGuest(
    AuthGuestSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthSuccess(message: 'Logged in as Guest'));
  }

  Future<void> onGoogle(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthSuccess(message: 'Google Sign-in successful'));
  }

  Future<void> onApple(
    AuthAppleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthSuccess(message: 'Apple Sign-in successful'));
  }
}
