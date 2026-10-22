import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:equatable/equatable.dart';

/// States emitted by HomeBloc
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial dormant state before fetching dashboard
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Loading state while fetching dashboard API
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Loaded state with live dashboard data and location dialog status
class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.dashboard,
    this.showLocationDialog = false,
  });

  final HomeDashboardEntity dashboard;
  final bool showLocationDialog;

  @override
  List<Object?> get props => [dashboard, showLocationDialog];
}

/// Error state on network or server failure
class HomeError extends HomeState {
  const HomeError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
