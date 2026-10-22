import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';

/// Contract for Home Screen data operations
abstract class HomeRepository {
  Future<Either<Failure, HomeDashboardEntity>> getHomeDashboard();
  Future<Either<Failure, UserLocationEntity>> getCurrentLocation();
}
