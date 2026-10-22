import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';

/// Use case to fetch home dashboard aggregated data
class GetHomeDashboardUseCase {
  const GetHomeDashboardUseCase(this.repository);

  final HomeRepository repository;

  Future<Either<Failure, HomeDashboardEntity>> call() =>
      repository.getHomeDashboard();
}
