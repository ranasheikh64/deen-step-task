import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/auth/domain/entities/auth_result_entity.dart';
import 'package:deen_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case executing anonymous guest login
class GuestLoginUseCase {
  const GuestLoginUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthResultEntity>> call({String? deviceId}) {
    return repository.guestLogin(deviceId: deviceId);
  }
}
