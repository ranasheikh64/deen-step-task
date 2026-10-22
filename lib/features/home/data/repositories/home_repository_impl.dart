import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';
import 'package:dio/dio.dart';

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
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final resData = e.response?.data;
      var msg = e.message ?? 'Server error';
      if (resData is Map) {
        final err = resData['error'];
        if (err is Map && err['message'] != null) {
          msg = err['message'].toString();
        } else if (resData['message'] != null) {
          msg = resData['message'].toString();
        }
      }
      if (code == 404) return Left(NotFoundFailure(msg, code));
      if (code == 401 || code == 403) return Left(AuthFailure(msg, code));
      if (code == 400 || code == 422) return Left(ValidationFailure(msg, code));
      return Left(ServerFailure(msg, code));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
