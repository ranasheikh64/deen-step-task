import 'package:equatable/equatable.dart';

/// Events handled by AuthBloc
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when submitting login credentials
class AuthLoginSubmitted extends AuthEvent {
  const AuthLoginSubmitted({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Triggered when submitting registration details
class AuthRegisterSubmitted extends AuthEvent {
  const AuthRegisterSubmitted({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.agreedToTerms,
  });

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool agreedToTerms;

  @override
  List<Object?> get props => [
    fullName,
    email,
    password,
    confirmPassword,
    agreedToTerms,
  ];
}

/// Triggered for Google OAuth sign-in
class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

/// Triggered for Apple OAuth sign-in
class AuthAppleSignInRequested extends AuthEvent {
  const AuthAppleSignInRequested();
}

/// Triggered for anonymous guest login
class AuthGuestSignInRequested extends AuthEvent {
  const AuthGuestSignInRequested();
}

/// Triggered when submitting OTP verification code
class AuthOtpSubmitted extends AuthEvent {
  const AuthOtpSubmitted({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}

/// Triggered when requesting OTP resend
class AuthResendOtpRequested extends AuthEvent {
  const AuthResendOtpRequested({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
