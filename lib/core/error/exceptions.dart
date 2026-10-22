/// Data layer exceptions thrown by remote and local sources
class ServerException implements Exception {
  ServerException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'ServerException(statusCode: $statusCode, message: $message)';
}

class NetworkException implements Exception {
  NetworkException([this.message = 'Network connection error']);

  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  CacheException([this.message = 'Local cache error']);

  final String message;

  @override
  String toString() => 'CacheException: $message';
}
