import 'package:deen_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';

/// Helper to convert DioException into structured ServerException
ServerException handleDioError(DioException error) {
  var message = 'An unexpected error occurred';
  final statusCode = error.response?.statusCode;
  String? errCode;
  int? retryAfter;

  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout) {
    message = 'Connection timed out. Please check your internet.';
  } else if (error.type == DioExceptionType.connectionError) {
    message =
        'Cannot connect to server. Please check your internet connection.';
  } else if (error.response?.data is Map<String, dynamic>) {
    final data = error.response!.data as Map<String, dynamic>;
    if (data['error'] is Map<String, dynamic>) {
      final err = data['error'] as Map<String, dynamic>;
      message = err['message'] as String? ?? message;
      errCode = err['code'] as String?;
      retryAfter = err['retry_after_seconds'] as int?;
    } else {
      message =
          data['message'] as String? ??
          data['detail'] as String? ??
          data['error'] as String? ??
          'Request failed with status $statusCode';
    }
  }

  retryAfter ??= int.tryParse(
    error.response?.headers.value('retry-after') ?? '',
  );

  return ServerException(
    message: message,
    statusCode: statusCode,
    code: errCode,
    retryAfterSeconds: retryAfter,
  );
}
