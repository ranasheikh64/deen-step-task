import 'package:deen_app/core/services/location/location_service.dart';
import 'package:deen_app/features/home/domain/usecases/get_current_location_usecase.dart';
import 'package:deen_app/features/home/domain/usecases/get_home_dashboard_usecase.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Business logic component for Home Screen dashboard and location permission
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getHomeDashboardUseCase,
    required this.getCurrentLocationUseCase,
    this.locationService = const LocationService(),
  }) : super(const HomeInitial()) {
    on<HomeDashboardRequested>(_onDashboardRequested);
    on<HomeLocationPermissionChecked>(_onPermissionChecked);
    on<HomeLocationPermissionRequested>(_onPermissionRequested);
  }

  final GetHomeDashboardUseCase getHomeDashboardUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final LocationService locationService;

  Future<void> _onDashboardRequested(
    HomeDashboardRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final hasPermission = await locationService.isPermissionGranted();
    final result = await getHomeDashboardUseCase();

    result.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (dashboard) => emit(
        HomeLoaded(
          dashboard: dashboard,
          showLocationDialog: !hasPermission,
        ),
      ),
    );
  }

  Future<void> _onPermissionChecked(
    HomeLocationPermissionChecked event,
    Emitter<HomeState> emit,
  ) async {
    final hasPermission = await locationService.isPermissionGranted();
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(
        HomeLoaded(
          dashboard: current.dashboard,
          showLocationDialog: !hasPermission,
        ),
      );
    }
  }

  Future<void> _onPermissionRequested(
    HomeLocationPermissionRequested event,
    Emitter<HomeState> emit,
  ) async {
    final granted = await locationService.requestPermission();
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(
        HomeLoaded(
          dashboard: current.dashboard,
          showLocationDialog: !granted,
        ),
      );
    }
    if (granted) {
      add(const HomeDashboardRequested());
    }
  }
}
