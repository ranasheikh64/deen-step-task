import 'package:deen_app/core/config/app_config.dart';
import 'package:deen_app/core/constants/app_constants.dart';
import 'package:deen_app/core/network/api_logger_interceptor.dart';
import 'package:deen_app/core/network/dio_error_handler.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Centralized Dio Network Client with Interceptors and Pretty Logging
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
      headers: const {'Content-Type': 'application/json', 'Accept': 'application/json'},
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
      _dio.interceptors.add(const ApiLoggerInterceptor());
    }
  }

  Future<Response<T>> _call<T>(Future<Response<T>> Function() req) async {
    try {
      return await req();
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _call(
      () =>
          _dio.get<T>(path, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _call(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _call(
      () => _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _call(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }
}
