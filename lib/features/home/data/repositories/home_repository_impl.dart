import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';

/// Implementation of HomeRepository managing data flow and network failures
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.remoteDataSource});

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, HomeDashboardEntity>> getHomeDashboard() =>
      _catch(remoteDataSource.getHomeDashboard);

  @override
  Future<Either<Failure, UserLocationEntity>> getCurrentLocation() =>
      _catch(remoteDataSource.getCurrentLocation);

  @override
  Future<Either<Failure, UserLocationEntity>> updateLocation({
    required String latitude,
    required String longitude,
  }) =>
      _catch(
        () => remoteDataSource.updateLocation(
          latitude: latitude,
          longitude: longitude,
        ),
      );

  Future<Either<Failure, T>> _catch<T>(Future<T> Function() fn) async {

    try {
      return Right(await fn());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
