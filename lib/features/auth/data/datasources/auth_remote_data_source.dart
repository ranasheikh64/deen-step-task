import 'package:deen_app/core/network/api_endpoints.dart';
import 'package:deen_app/core/network/dio_client.dart';
import 'package:deen_app/features/auth/data/models/auth_response_model.dart';
import 'package:dio/dio.dart';

/// Contract and implementation for remote authentication API calls
abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
    String? deviceId,
  });

  Future<String> register({
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
  });

  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
    String? deviceId,
  });

  Future<String> resendOtp({required String email});

  Future<AuthResponseModel> guestLogin({required String deviceId});

  Future<void> logout({required String refreshToken});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.client});

  final DioClient client;

  String _validDeviceId(String? id) =>
      (id != null && id.isNotEmpty) ? id : 'dev_${DateTime.now().millisecondsSinceEpoch}';

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
    String? deviceId,
  }) async {
    final response = await client.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: {'email': email, 'password': password, 'device_id': _validDeviceId(deviceId)},
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<String> register({
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
  }) async {
    final response = await client.post<Map<String, dynamic>>(
      ApiEndpoints.signUp,
      data: {
        'full_name': fullName ?? '',
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      },
    );
    final data = response.data?['data'] as Map<String, dynamic>?;
    return data?['detail'] as String? ?? 'OTP sent to email';
  }

  @override
  Future<AuthResponseModel> verifyOtp({
    required String email,
    required String otp,
    String? deviceId,
  }) async {
    final response = await client.post<Map<String, dynamic>>(
      ApiEndpoints.signUpVerify,
      data: {'email': email, 'otp': otp, 'device_id': _validDeviceId(deviceId)},
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<String> resendOtp({required String email}) async {
    final response = await client.post<Map<String, dynamic>>(
      ApiEndpoints.resetOtpRequest,
      data: {'email': email},
    );
    final data = response.data?['data'] as Map<String, dynamic>?;
    return data?['detail'] as String? ?? 'OTP sent successfully';
  }

  @override
  Future<AuthResponseModel> guestLogin({required String deviceId}) async {
    final response = await client.post<Map<String, dynamic>>(
      ApiEndpoints.guestLogin,
      data: FormData.fromMap({'device_id': _validDeviceId(deviceId)}),
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    await client.post<Map<String, dynamic>>(
      ApiEndpoints.logout,
      data: FormData.fromMap({'refresh': refreshToken}),
    );
  }
}
