import 'package:equatable/equatable.dart';

/// Events handled by HomeBloc
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Request to fetch/refresh full home dashboard data
class HomeDashboardRequested extends HomeEvent {
  const HomeDashboardRequested();
}

/// Triggered to check location permission status
class HomeLocationPermissionChecked extends HomeEvent {
  const HomeLocationPermissionChecked();
}

/// Triggered when user taps "Turn On Location" in EnableLocationDialog
class HomeLocationPermissionRequested extends HomeEvent {
  const HomeLocationPermissionRequested();
}
