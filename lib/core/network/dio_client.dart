import 'package:deen_app/core/config/app_config.dart';
import 'package:deen_app/core/constants/app_constants.dart';
import 'package:deen_app/core/error/exceptions.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Centralized Dio Network Client with Interceptors
class DioClient {
  DioClient({required this.secureStorage, Dio? dio}) : _dio = dio ?? Dio() {
    _initDio();
  }

  final Dio _dio;
  final SecureStorageService secureStorage;

  Dio get dio => _dio;

  void _initDio() {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await secureStorage.clearAll();
          }
          return handler.next(error);
        },
      ),
    );

    if (kDebugMode && AppConfig.instance.enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ServerException _handleDioError(DioException error) {
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
}
