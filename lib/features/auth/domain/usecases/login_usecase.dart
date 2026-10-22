import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for authenticating user via email and password
class LoginUseCase {
  const LoginUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthResultEntity>> call({
    required String email,
    required String password,
    String? deviceId,
  }) {
    return repository.login(
      email: email,
      password: password,
      deviceId: deviceId,
    );
  }
}
