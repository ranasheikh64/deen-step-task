import 'package:deen_app/core/error/exceptions.dart';
import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:deen_app/features/auth/data/datasources/social_auth_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeDio extends Fake implements Dio;

class FakeSecureStorage extends Fake implements SecureStorageService;

class _MockDioClient extends Fake implements DioClient {
  _MockDioClient(this.postHandler);

  final Future<Response<Map<String, dynamic>>> Function(
    String path, {
    dynamic data,
  }) postHandler;

  @override
  Dio get dio => _FakeDio();

  @override
  SecureStorageService get secureStorage => FakeSecureStorage();

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final res = await postHandler(path, data: data);
    return res as Response<T>;
  }
}

void main() {
  const successData = {
    'status': 'Success',
    'code': 200,
    'data': {
      'detail': 'Login successful.',
      'access': 'access_token_123',
      'refresh': 'refresh_token_123',
      'user': {
        'id': 42,
        'email': 'user@example.com',
        'full_name': 'Test User',
        'is_verified': true,
      },
    },
  };

  test('socialAuth succeeds on first attempt', () async {
    final client = _MockDioClient((path, {data}) async {
      expect(path, '/auth/social/login/');
      expect((data as Map)['provider'], 'google');
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: successData,
      );
    });

    final dataSource = SocialAuthRemoteDataSourceImpl(client: client);
    final res = await dataSource.socialAuth(idToken: 'fb_token', provider: 'google');
    expect(res.accessToken, 'access_token_123');
    expect(res.user.email, 'user@example.com');
  });

  test('socialAuth cross-replies to sign-up when 404 SOCIAL_ACCOUNT_NOT_FOUND', () async {
    final calledPaths = <String>[];
    final client = _MockDioClient((path, {data}) async {
      calledPaths.add(path);
      if (path == '/auth/social/login/') {
        throw ServerException(
          statusCode: 404,
          code: 'SOCIAL_ACCOUNT_NOT_FOUND',
          message: 'No account registered',
        );
      }
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 201,
        data: successData,
      );
    });

    final dataSource = SocialAuthRemoteDataSourceImpl(client: client);
    final res = await dataSource.socialAuth(idToken: 'fb_token', provider: 'google');
    expect(calledPaths, ['/auth/social/login/', '/auth/social/sign-up/']);
    expect(res.accessToken, 'access_token_123');
  });
}
