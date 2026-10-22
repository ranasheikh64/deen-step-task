import 'package:deen_app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

/// Domain entity representing the result of successful authentication
class AuthResultEntity extends Equatable {
  const AuthResultEntity({
    required this.user,
    this.accessToken,
    this.refreshToken,
    this.detail,
  });

  final UserEntity user;
  final String? accessToken;
  final String? refreshToken;
  final String? detail;

  @override
  List<Object?> get props => [user, accessToken, refreshToken, detail];
}
