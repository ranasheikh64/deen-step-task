import 'package:deen_app/core/di/service_locator.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:deen_app/features/home/presentation/bloc/home_event.dart';
import 'package:deen_app/features/home/presentation/bloc/home_state.dart';
import 'package:deen_app/features/home/presentation/widgets/enable_location_dialog.dart';
import 'package:deen_app/features/home/presentation/widgets/home_body_content.dart';
import 'package:deen_app/features/home/presentation/widgets/home_error_widget.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_header_widget.dart';
import 'package:deen_app/features/home/presentation/widgets/home_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Home Screen with live API data, real-time clock, and shimmer loading state
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.homeBloc});

  final HomeBloc? homeBloc;

  @override
  Widget build(BuildContext context) {
    if (homeBloc == null && !sl.isRegistered<HomeBloc>()) {
      return const HomeScreenShimmer();
    }
    return BlocProvider(
      create: (context) => (homeBloc ?? sl<HomeBloc>())..add(const HomeDashboardRequested()),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoaded && state.showLocationDialog) {
            EnableLocationDialog.show(
              context,
              onTurnOnLocation: () =>
                  context.read<HomeBloc>().add(const HomeLocationPermissionRequested()),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) return const HomeScreenShimmer();
          if (state is HomeError) {
            return HomeErrorWidget(
              message: state.message,
              onRetry: () => context.read<HomeBloc>().add(const HomeDashboardRequested()),
            );
          }
          if (state is! HomeLoaded) return const SizedBox.shrink();

          final d = state.dashboard;
          final loc = d.location.address.isNotEmpty
              ? d.location.address
              : (d.location.city.isNotEmpty ? d.location.city : '');

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => context.read<HomeBloc>().add(const HomeDashboardRequested()),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  HomePrayerHeaderWidget(
                    location: loc,
                    hijriDate: d.hijriDate,
                    gregorianDate: d.gregorianDate,
                    nextPrayerName: d.nextPrayerName,
                    nextPrayerTime: d.nextPrayerTime,
                    timings: d.timings,
                    activePrayer: d.nextPrayerName,
                  ),
                  HomeBodyContent(dashboard: d),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
