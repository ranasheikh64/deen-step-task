import 'dart:async';
import 'dart:io';
import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/core/theme/app_spacing.dart';
import 'package:deen_app/core/theme/app_typography.dart';
import 'package:deen_app/features/home/presentation/widgets/home_countdown_helper.dart';
import 'package:deen_app/features/home/presentation/widgets/home_header_chips.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_timeline_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Mosque header with notch integration and live ticking clock and countdown
class HomePrayerHeaderWidget extends StatefulWidget {
  const HomePrayerHeaderWidget({
    required this.location,
    required this.hijriDate,
    required this.gregorianDate,
    super.key,
    this.nextPrayerName = '',
    this.nextPrayerTime = '',
    this.timings = const {},
    this.activePrayer = 'Dhuhr',
  });

  final String location;
  final String hijriDate;
  final String gregorianDate;
  final String nextPrayerName;
  final String nextPrayerTime;
  final Map<String, String> timings;
  final String activePrayer;

  static const _radius = BorderRadius.vertical(bottom: Radius.circular(AppSpacing.radiusXxl));

  @override
  State<HomePrayerHeaderWidget> createState() => _HomePrayerHeaderWidgetState();
}

class _HomePrayerHeaderWidgetState extends State<HomePrayerHeaderWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (kIsWeb || !Platform.environment.containsKey('FLUTTER_TEST')) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final now = DateTime.now();
    final hourStr = now.hour.toString().padLeft(2, '0');
    final minStr = ':${now.minute.toString().padLeft(2, '0')}';
    final cdText = formatPrayerCountdown(widget.nextPrayerName, widget.nextPrayerTime);

    return Container(
      width: double.infinity,
      height: 360 + topPadding,
      decoration: const BoxDecoration(color: AppColors.homeHeaderBackground, borderRadius: HomePrayerHeaderWidget._radius),
      child: ClipRRect(
        borderRadius: HomePrayerHeaderWidget._radius,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AssetPaths.imgHomeMosqueHeader, fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(0.35)),
            ),
            Positioned(
              right: -10,
              top: topPadding + 10,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.homeSunCore, AppColors.homeSunGlow.withValues(alpha: 0.75), AppColors.homeSunOuter.withValues(alpha: 0.3), AppColors.transparent],
                    stops: const [0.0, 0.45, 0.75, 1.0],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(AppSpacing.lg, topPadding + AppSpacing.xs, AppSpacing.lg, AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: HomeLocationChip(location: widget.location)),
                  const SizedBox(height: AppSpacing.md),
                  Text(widget.hijriDate, style: AppTypography.bodyMedium(color: AppColors.textPrimary.withValues(alpha: 0.9))),
                  const SizedBox(height: AppSpacing.xs),
                  HomeTimeAndDateDisplay(hour: hourStr, minute: minStr, date: widget.gregorianDate),
                  if (cdText.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    HomeCountdownChip(countdownText: cdText),
                  ],
                  const Spacer(),
                  HomePrayerTimelineRow(timings: widget.timings, activePrayer: widget.activePrayer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
