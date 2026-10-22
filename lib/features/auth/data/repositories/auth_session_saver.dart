import 'dart:convert';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';

/// Helper to persist auth tokens and user data securely
Future<void> saveAuthSession(
  SecureStorageService storage,
  AuthResultEntity res,
) async {
  if (res.accessToken?.isNotEmpty ?? false) {
    await storage.saveToken(res.accessToken!);
  }
  if (res.refreshToken?.isNotEmpty ?? false) {
    await storage.saveRefreshToken(res.refreshToken!);
  }
  final u = res.user;
  await storage.saveUserData(
    jsonEncode({
      'id': u.id,
      'email': u.email,
      'full_name': u.fullName,
      'mobile': u.mobile,
      'is_verified': u.isVerified,
    }),
  );
}
