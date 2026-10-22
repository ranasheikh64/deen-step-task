import 'dart:convert';
import 'package:deen_app/core/constants/app_constants.dart';
import 'package:deen_app/core/routing/app_routes.dart';
import 'package:deen_app/core/services/auth/auth_session_manager.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

String _createDummyJwt({required int expSecondsFromNow}) {
  final header = base64Url.encode(utf8.encode('{"alg":"HS256","typ":"JWT"}'));
  final exp = (DateTime.now().millisecondsSinceEpoch ~/ 1000) + expSecondsFromNow;
  final payload = base64Url.encode(utf8.encode('{"user_id":"444","exp":$exp}'));
  return '$header.$payload.dummySignature';
}

class FakeStorage extends SecureStorageService {
  final Map<String, String> _data = {};

  @override
  Future<void> saveToken(String token) async => _data[AppConstants.tokenKey] = token;

  @override
  Future<String?> getToken() async => _data[AppConstants.tokenKey];

  @override
  Future<void> saveRefreshToken(String token) async => _data[AppConstants.refreshTokenKey] = token;

  @override
  Future<String?> getRefreshToken() async => _data[AppConstants.refreshTokenKey];

  @override
  Future<void> clearAll() async => _data.clear();
}

void main() {
  late FakeStorage fakeStorage;

  setUp(() {
    fakeStorage = FakeStorage();
  });

  test('returns onboarding when access and refresh tokens are empty', () async {
    final manager = AuthSessionManager(secureStorage: fakeStorage);
    final route = await manager.determineInitialRoute();
    expect(route, AppRoutes.onboarding);
  });

  test('returns dashboard when access token is valid and unexpired', () async {
    final validToken = _createDummyJwt(expSecondsFromNow: 3600);
    await fakeStorage.saveToken(validToken);

    final manager = AuthSessionManager(secureStorage: fakeStorage);
    final route = await manager.determineInitialRoute();
    expect(route, AppRoutes.dashboard);
  });

  test('returns login when both access and refresh tokens are expired', () async {
    final expiredToken = _createDummyJwt(expSecondsFromNow: -3600);
    await fakeStorage.saveToken(expiredToken);
    await fakeStorage.saveRefreshToken(expiredToken);

    final manager = AuthSessionManager(secureStorage: fakeStorage);
    final route = await manager.determineInitialRoute();
    expect(route, AppRoutes.login);
    expect(await fakeStorage.getToken(), isNull);
  });

  test('returns dashboard when access token is expired but refresh succeeds', () async {
    final expiredToken = _createDummyJwt(expSecondsFromNow: -3600);
    final validRefreshToken = _createDummyJwt(expSecondsFromNow: 3600);
    final newAccessToken = _createDummyJwt(expSecondsFromNow: 7200);

    await fakeStorage.saveToken(expiredToken);
    await fakeStorage.saveRefreshToken(validRefreshToken);

    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: {
                'status': 'Success',
                'data': {'access': newAccessToken},
              },
            ),
          );
        },
      ),
    );

    final manager = AuthSessionManager(secureStorage: fakeStorage, dio: dio);
    final route = await manager.determineInitialRoute();
    expect(route, AppRoutes.dashboard);
    expect(await fakeStorage.getToken(), newAccessToken);
  });
}
