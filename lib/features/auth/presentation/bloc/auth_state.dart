import 'package:equatable/equatable.dart';

/// Base state for authentication operations
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial resting state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Active asynchronous network request
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Successful login or guest authorization
class AuthSuccess extends AuthState {
  const AuthSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Registration succeeded, awaiting email OTP confirmation
class AuthRequiresVerification extends AuthState {
  const AuthRequiresVerification({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

/// Operation failed with user-facing error message
class AuthFailureState extends AuthState {
  const AuthFailureState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
