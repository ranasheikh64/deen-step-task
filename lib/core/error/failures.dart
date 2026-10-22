import 'package:equatable/equatable.dart';

/// Base class for all failure representations in the domain layer
abstract class Failure extends Equatable {
  const Failure(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, [super.statusCode]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No internet connection',
    super.statusCode,
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure([
    super.message = 'Unauthorized or session expired',
    super.statusCode = 401,
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache retrieval failed']);
}

class TooManyAttemptsFailure extends Failure {
  const TooManyAttemptsFailure({
    String message = 'Too many attempts. Please try again later.',
    this.retryAfterSeconds = 60,
    int? statusCode = 429,
  }) : super(message, statusCode);

  final int retryAfterSeconds;

  @override
  List<Object?> get props => [message, retryAfterSeconds, statusCode];
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.statusCode = 400]);
}
