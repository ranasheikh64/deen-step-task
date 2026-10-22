import 'package:deen_app/core/constants/app_constants.dart';
import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/network/api_endpoints.dart';
import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

/// Secure storage wrapper for sensitive credentials and tokens
class SecureStorageService {
  SecureStorageService([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }

  Future<String?> getToken() {
    return _storage.read(key: AppConstants.tokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: AppConstants.refreshTokenKey);
  }

  Future<void> saveUserData(String userData) async {
    await _storage.write(key: AppConstants.userKey, value: userData);
  }

  Future<String?> getUserData() {
    return _storage.read(key: AppConstants.userKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> logout(BuildContext context) async {
    final ref = await getRefreshToken() ?? '';
    if (ref.isNotEmpty && sl.isRegistered<DioClient>()) {
      try {
        await sl<DioClient>().post<Map<String, dynamic>>(
          ApiEndpoints.logout,
          data: FormData.fromMap({'refresh': ref}),
        );
      } on Object catch (e) {
        debugPrint('Logout API notice: $e');
      }
    }
    await clearAll();
    if (!context.mounted) return;
    GoRouter.of(context).go(AppRoutes.login);
  }
}
