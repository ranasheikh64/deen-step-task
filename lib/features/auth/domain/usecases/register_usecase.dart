import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for registering a new user and requesting OTP
class RegisterUseCase {
  const RegisterUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
  }) {
    return repository.register(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      fullName: fullName,
    );
  }
}
