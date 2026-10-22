import 'package:deen_app/core/config/app_config.dart';
import 'package:deen_app/core/constants/app_constants.dart';
import 'package:deen_app/core/network/api_endpoints.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Manages auth sessions, JWT token validation, refresh calls, and routing
class AuthSessionManager {
  AuthSessionManager({required this.secureStorage, Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: AppConfig.instance.baseUrl,
              connectTimeout: AppConstants.connectTimeout,
              receiveTimeout: AppConstants.receiveTimeout,
              headers: const {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

  final SecureStorageService secureStorage;
  final Dio _dio;

  /// Checks if a JWT token exists, has valid structure, and is not expired
  bool isTokenValid(String? token) {
    if (token == null || token.trim().isEmpty) return false;
    try {
      return !JwtDecoder.isExpired(token);
    } on Object {
      return false;
    }
  }

  /// Refreshes access token via API and updates secure storage
  Future<bool> refreshAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );
      final body = response.data;
      if (body != null) {
        final data = body['data'] as Map<String, dynamic>? ?? body;
        final newAccess = data['access'] as String?;
        final newRefresh = data['refresh'] as String?;
        if (newAccess != null && newAccess.isNotEmpty) {
          await secureStorage.saveToken(newAccess);
          if (newRefresh != null && newRefresh.isNotEmpty) {
            await secureStorage.saveRefreshToken(newRefresh);
          }
          return true;
        }
      }
      return false;
    } on Object catch (e) {
      debugPrint('⚠️ [TokenRefresh] API Error: $e');
      return false;
    }
  }

  /// Determines the launch route based on JWT token lifecycle
  Future<String> determineInitialRoute() async {
    final access = await secureStorage.getToken();
    final refresh = await secureStorage.getRefreshToken();

    // 1. Both tokens empty -> Onboarding
    if ((access == null || access.isEmpty) &&
        (refresh == null || refresh.isEmpty)) {
      return AppRoutes.onboarding;
    }

    // 2. Access token is valid -> Dashboard
    if (isTokenValid(access)) {
      return AppRoutes.dashboard;
    }

    // 3. Access token expired/invalid -> attempt refresh
    if (isTokenValid(refresh)) {
      final success = await refreshAccessToken(refresh!);
      if (success) {
        return AppRoutes.dashboard;
      }
    }

    // 4. Refresh token expired or refresh failed -> Login
    await secureStorage.clearAll();
    return AppRoutes.login;
  }
}
