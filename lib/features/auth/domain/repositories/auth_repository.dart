import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';

/// Contract for Authentication repository operations using dartz Either
abstract class AuthRepository {
  Future<Either<Failure, AuthResultEntity>> login({
    required String email,
    required String password,
    String? deviceId,
  });

  Future<Either<Failure, String>> register({
    required String email,
    required String password,
    required String confirmPassword,
    String? fullName,
  });

  Future<Either<Failure, AuthResultEntity>> verifyOtp({
    required String email,
    required String otp,
    String? deviceId,
  });

  Future<Either<Failure, String>> resendOtp({required String email});

  Future<Either<Failure, AuthResultEntity>> guestLogin({
    required String deviceId,
  });

  Future<Either<Failure, void>> logout();
}
