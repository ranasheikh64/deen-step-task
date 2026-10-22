import 'package:deen_app/features/home/presentation/widgets/home_screen_shimmer.dart';
import 'package:flutter/material.dart';

/// Offline or test fallback rendering shimmer loader
class HomeScreenFallback extends StatelessWidget {
  const HomeScreenFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenShimmer();
  }
}
