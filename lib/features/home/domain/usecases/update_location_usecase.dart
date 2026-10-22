import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';

/// Use case to sync device GPS coordinates with the backend
class UpdateLocationUseCase {
  const UpdateLocationUseCase(this.repository);

  final HomeRepository repository;

  Future<Either<Failure, UserLocationEntity>> call({
    required String latitude,
    required String longitude,
  }) =>
      repository.updateLocation(latitude: latitude, longitude: longitude);
}
