import 'package:deen_app/features/auth/data/models/user_model.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';

/// Data transfer model for AuthResultEntity
class AuthResponseModel extends AuthResultEntity {
  const AuthResponseModel({
    required super.user,
    super.accessToken,
    super.refreshToken,
    super.detail,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final userJson = data['user'] as Map<String, dynamic>? ?? {};

    return AuthResponseModel(
      user: UserModel.fromJson(userJson),
      accessToken: data['access'] as String?,
      refreshToken: data['refresh'] as String?,
      detail: data['detail'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserModel).toJson(),
      'access': accessToken,
      'refresh': refreshToken,
      'detail': detail,
    };
  }
}
