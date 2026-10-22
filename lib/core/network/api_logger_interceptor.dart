import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Pretty console logger for API requests, responses, and errors
class ApiLoggerInterceptor extends Interceptor {
  const ApiLoggerInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌── 🌐 [API REQUEST] ${options.method} ${options.uri}');
      if (options.queryParameters.isNotEmpty) {
        debugPrint('│ Query: ${options.queryParameters}');
      }
      if (options.data != null) {
        debugPrint('│ Body: ${_prettyJson(options.data)}');
      }
      debugPrint('└──');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      final req = response.requestOptions;
      debugPrint(
        '┌── ✅ [API SUCCESS ${response.statusCode}] '
        '${req.method} ${req.uri}',
      );
      if (response.data != null) {
        debugPrint('│ Data: ${_prettyJson(response.data)}');
      }
      debugPrint('└──');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final req = err.requestOptions;
      final status = err.response?.statusCode ?? 'NO_STATUS';
      debugPrint('┌── ❌ [API ERROR $status] ${req.method} ${req.uri}');
      debugPrint('│ Type: ${err.type}');
      debugPrint('│ Message: ${err.message}');
      if (err.response?.data != null) {
        debugPrint('│ Response: ${_prettyJson(err.response!.data)}');
      }
      debugPrint('└──');
    }
    super.onError(err, handler);
  }

  String _prettyJson(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } on Object catch (_) {
      return data.toString();
    }
  }
}
