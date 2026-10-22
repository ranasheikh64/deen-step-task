import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for confirming 4-digit OTP code
class VerifyOtpUseCase {
  const VerifyOtpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthResultEntity>> call({
    required String email,
    required String otp,
    String? deviceId,
  }) {
    return repository.verifyOtp(email: email, otp: otp, deviceId: deviceId);
  }
}
