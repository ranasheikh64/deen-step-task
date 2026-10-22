import 'package:deen_app/core/error/exceptions.dart';
import 'package:deen_app/core/error/failures.dart';

/// Helper function to map data exceptions to domain failures
Failure mapAuthError(Object error) {
  if (error is ServerException) {
    if (error.statusCode == 429 || error.code == 'TOO_MANY_ATTEMPTS') {
      return TooManyAttemptsFailure(
        message: error.message,
        retryAfterSeconds: error.retryAfterSeconds ?? 60,
      );
    }
    if (error.statusCode == 400) return ValidationFailure(error.message);
    if (error.statusCode == 401) return AuthFailure(error.message);
    return ServerFailure(error.message, error.statusCode);
  }
  if (error is NetworkException) return NetworkFailure(error.message);
  return ServerFailure(error.toString());
}
