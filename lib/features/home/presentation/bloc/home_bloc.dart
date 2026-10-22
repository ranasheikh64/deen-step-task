import 'package:deen_app/core/services/location/location_service.dart';
import 'package:deen_app/features/home/domain/usecases/get_current_location_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/update_location_usecase.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Business logic component for Home Screen dashboard and location
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getHomeDashboardUseCase,
    required this.getCurrentLocationUseCase,
    required this.updateLocationUseCase,
    this.locationService = const LocationService(),
  }) : super(const HomeInitial()) {
    on<HomeDashboardRequested>(_onDashboardRequested);
    on<HomeLocationPermissionChecked>(_onPermissionChecked);
    on<HomeLocationPermissionRequested>(_onPermissionRequested);
  }

  final GetHomeDashboardUseCase getHomeDashboardUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final UpdateLocationUseCase updateLocationUseCase;
  final LocationService locationService;

  Future<bool> _syncCoordinatesIfAllowed() async {
    final granted = await locationService.isPermissionGranted();
    if (!granted) return false;
    final pos = await locationService.getCurrentPosition();
    final lat = pos != null ? pos.latitude.toStringAsFixed(6) : '23.810300';
    final lng = pos != null ? pos.longitude.toStringAsFixed(6) : '90.412500';
    final result = await updateLocationUseCase(latitude: lat, longitude: lng);
    return result.isRight();
  }

  Future<void> _onDashboardRequested(
    HomeDashboardRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final hasPermission = await locationService.isPermissionGranted();
    if (hasPermission) {
      await _syncCoordinatesIfAllowed();
    } else {
      await getCurrentLocationUseCase();
    }

    final result = await getHomeDashboardUseCase();
    await result.fold(
      (failure) async => emit(HomeError(message: failure.message)),
      (dashboard) async {
        if (dashboard.isLocationRequired || dashboard.timings.isEmpty) {
          if (hasPermission) {
            final synced = await _syncCoordinatesIfAllowed();
            if (synced) {
              final refetched = await getHomeDashboardUseCase();
              refetched.fold(
                (_) => emit(HomeLoaded(dashboard: dashboard, showLocationDialog: false)),
                (newD) => emit(HomeLoaded(dashboard: newD, showLocationDialog: false)),
              );
              return;
            }
          }
          emit(HomeLoaded(dashboard: dashboard, showLocationDialog: true));
        } else {
          emit(HomeLoaded(dashboard: dashboard, showLocationDialog: !hasPermission));
        }
      },
    );
  }

  Future<void> _onPermissionChecked(
    HomeLocationPermissionChecked event,
    Emitter<HomeState> emit,
  ) async {
    final hasPermission = await locationService.isPermissionGranted();
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(HomeLoaded(
        dashboard: current.dashboard,
        showLocationDialog: !hasPermission,
      ));
    }
  }

  Future<void> _onPermissionRequested(
    HomeLocationPermissionRequested event,
    Emitter<HomeState> emit,
  ) async {
    final granted = await locationService.requestPermission();
    emit(const HomeLoading());
    if (granted) {
      await _syncCoordinatesIfAllowed();
    } else {
      await updateLocationUseCase(latitude: '23.810300', longitude: '90.412500');
    }
    final result = await getHomeDashboardUseCase();
    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (dashboard) => emit(HomeLoaded(dashboard: dashboard, showLocationDialog: false)),
    );
  }
}
