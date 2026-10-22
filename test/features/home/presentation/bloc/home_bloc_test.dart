import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/core/services/location/location_service.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';
import 'package:deen_app/features/home/domain/usecases/get_current_location_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeHomeRepository implements HomeRepository {
  bool shouldFail = false;

  @override
  Future<Either<Failure, HomeDashboardEntity>> getHomeDashboard() async {
    if (shouldFail) return const Left(ServerFailure('Failed to load'));
    return const Right(
      HomeDashboardEntity(
        location: UserLocationEntity(address: 'Dhaka, Bangladesh'),
        dailyGoalCompleted: 3,
        streakCurrent: 5,
      ),
    );
  }

  @override
  Future<Either<Failure, UserLocationEntity>> getCurrentLocation() async {
    return const Right(UserLocationEntity(address: 'Dhaka, Bangladesh'));
  }
}

class FakeLocationService extends LocationService {
  bool isGranted = false;

  @override
  Future<bool> isPermissionGranted() async => isGranted;

  @override
  Future<bool> requestPermission() async {
    isGranted = true;
    return true;
  }
}

void main() {
  late FakeHomeRepository fakeRepo;
  late FakeLocationService fakeLocation;
  late HomeBloc bloc;

  setUp(() {
    fakeRepo = FakeHomeRepository();
    fakeLocation = FakeLocationService();
    bloc = HomeBloc(
      getHomeDashboardUseCase: GetHomeDashboardUseCase(fakeRepo),
      getCurrentLocationUseCase: GetCurrentLocationUseCase(fakeRepo),
      locationService: fakeLocation,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('emits [HomeLoading, HomeLoaded] on successful dashboard request', () async {
    final future = expectLater(
      bloc.stream,
      emitsInOrder([
        const HomeLoading(),
        isA<HomeLoaded>()
            .having((s) => s.showLocationDialog, 'showLocationDialog', isTrue)
            .having((s) => s.dashboard.dailyGoalCompleted, 'completed', 3),
      ]),
    );

    bloc.add(const HomeDashboardRequested());
    await future;
  });

  test('emits [HomeLoading, HomeError] when dashboard request fails', () async {
    fakeRepo.shouldFail = true;

    final future = expectLater(
      bloc.stream,
      emitsInOrder([
        const HomeLoading(),
        isA<HomeError>().having((s) => s.message, 'message', 'Failed to load'),
      ]),
    );

    bloc.add(const HomeDashboardRequested());
    await future;
  });
}
