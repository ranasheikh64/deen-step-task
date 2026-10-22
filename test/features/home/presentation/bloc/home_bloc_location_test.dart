import 'package:dartz/dartz.dart';
import 'package:deen_app/core/error/failures.dart';
import 'package:deen_app/core/services/location/location_service.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:deen_app/features/home/domain/repositories/home_repository.dart';
import 'package:deen_app/features/home/domain/usecases/get_current_location_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/update_location_usecase.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

class _MockHomeRepo implements HomeRepository {
  String? updatedLat;
  String? updatedLng;

  @override
  Future<Either<Failure, HomeDashboardEntity>> getHomeDashboard() async {
    return const Right(
      HomeDashboardEntity(
        isLocationRequired: false,
        timings: {'Fajr': '05:00', 'Dhuhr': '12:00'},
        nextPrayerName: 'Fajr',
      ),
    );
  }

  @override
  Future<Either<Failure, UserLocationEntity>> getCurrentLocation() async =>
      const Left(NotFoundFailure('No location saved.'));

  @override
  Future<Either<Failure, UserLocationEntity>> updateLocation({
    required String latitude,
    required String longitude,
  }) async {
    updatedLat = latitude;
    updatedLng = longitude;
    return const Right(UserLocationEntity());
  }
}

class _MockLocationService extends LocationService {
  @override
  Future<bool> isPermissionGranted() async => true;

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<Position?> getCurrentPosition() async => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('HomeLocationPermissionRequested updates location with max 6 decimals', () async {
    final repo = _MockHomeRepo();
    final bloc = HomeBloc(
      getHomeDashboardUseCase: GetHomeDashboardUseCase(repo),
      getCurrentLocationUseCase: GetCurrentLocationUseCase(repo),
      updateLocationUseCase: UpdateLocationUseCase(repo),
      locationService: _MockLocationService(),
    );

    final future = expectLater(
      bloc.stream,
      emitsInOrder([
        const HomeLoading(),
        isA<HomeLoaded>()
            .having((s) => s.showLocationDialog, 'showLocationDialog', isFalse)
            .having((s) => s.dashboard.nextPrayerName, 'nextPrayer', 'Fajr'),
      ]),
    );

    bloc.add(const HomeLocationPermissionRequested());
    await future;

    expect(repo.updatedLat, isNotNull);
    expect(repo.updatedLng, isNotNull);
    expect(repo.updatedLat!.contains('.'), isTrue);
    final decimals = repo.updatedLat!.split('.').last.length;
    expect(decimals, lessThanOrEqualTo(6));

    await bloc.close();
  });
}
