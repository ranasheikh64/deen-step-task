import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for resending a fresh OTP code to user email
class ResendOtpUseCase {
  const ResendOtpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, String>> call({required String email}) {
    return repository.resendOtp(email: email);
  }
}
