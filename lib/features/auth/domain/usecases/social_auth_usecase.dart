import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case executing social authentication flow
class SocialAuthUseCase {
  const SocialAuthUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthResultEntity>> call({
    required String idToken,
    required String provider,
    String? deviceId,
  }) {
    return repository.socialAuth(
      idToken: idToken,
      provider: provider,
      deviceId: deviceId,
    );
  }
}
