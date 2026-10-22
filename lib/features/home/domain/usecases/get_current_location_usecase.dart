import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';

/// Use case to fetch stored location for the current authenticated user
class GetCurrentLocationUseCase {
  const GetCurrentLocationUseCase(this.repository);

  final HomeRepository repository;

  Future<Either<Failure, UserLocationEntity>> call() =>
      repository.getCurrentLocation();
}
