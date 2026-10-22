import 'package:deen_app/core/error/exceptions.dart';
import 'package:deen_app/core/network/api_endpoints.dart';
import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/features/auth/data/models/auth_response_model.dart';

abstract class SocialAuthRemoteDataSource {
  Future<AuthResponseModel> socialAuth({
    required String idToken,
    required String provider,
    String? deviceId,
  });
}

class SocialAuthRemoteDataSourceImpl implements SocialAuthRemoteDataSource {
  const SocialAuthRemoteDataSourceImpl({required this.client});

  final DioClient client;

  @override
  Future<AuthResponseModel> socialAuth({
    required String idToken,
    required String provider,
    String? deviceId,
  }) async {
    final payload = <String, dynamic>{
      'id_token': idToken,
      'provider': provider,
      if (deviceId != null && deviceId.isNotEmpty) 'device_id': deviceId,
    };

    try {
      final res = await client.post<Map<String, dynamic>>(
        ApiEndpoints.socialLogin,
        data: payload,
      );
      return AuthResponseModel.fromJson(res.data!);
    } on ServerException catch (e) {
      if (e.code == 'SOCIAL_ACCOUNT_NOT_FOUND' || e.statusCode == 404) {
        return await _signUpCrossReply(payload);
      }
      rethrow;
    }
  }

  Future<AuthResponseModel> _signUpCrossReply(
    Map<String, dynamic> payload,
  ) async {
    try {
      final res = await client.post<Map<String, dynamic>>(
        ApiEndpoints.socialSignUp,
        data: payload,
      );
      return AuthResponseModel.fromJson(res.data!);
    } on ServerException catch (e) {
      if (e.code == 'SOCIAL_ACCOUNT_EXISTS' || e.statusCode == 409) {
        final loginRes = await client.post<Map<String, dynamic>>(
          ApiEndpoints.socialLogin,
          data: payload,
        );
        return AuthResponseModel.fromJson(loginRes.data!);
      }
      rethrow;
    }
  }
}
