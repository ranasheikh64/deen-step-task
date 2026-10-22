import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_step_item.dart';
import 'package:flutter/material.dart';

/// Prayer timeline row matching Figma node 1:416 with custom aligned step items
class HomePrayerTimelineRow extends StatelessWidget {
  const HomePrayerTimelineRow({
    super.key,
    this.timings = const {},
    this.activePrayer = 'Dhuhr',
  });

  final Map<String, String> timings;
  final String activePrayer;

  static const List<(String, String, String)> _prayers = [
    ('Fajr', AssetPaths.icPrayerFajr, '04:03'),
    ('Dhuhr', AssetPaths.icPrayerDhuhr, '11:37'),
    ('Asr', AssetPaths.icPrayerAsr, '15:00'),
    ('Maghrib', AssetPaths.icPrayerMaghrib, '17:48'),
    ('Isha', AssetPaths.icPrayerFajr, '19:02'),
  ];

  @override
  Widget build(BuildContext context) {
    final activeLower = activePrayer.toLowerCase();
    final activeIdx = _prayers.indexWhere(
      (p) => p.$1.toLowerCase() == activeLower,
    );
    final currentIdx = activeIdx == -1 ? 1 : activeIdx;

    return SizedBox(
      height: 104,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final step = (w - 52.0) / 4.0;

          return Stack(
            children: [
              ...List.generate(4, (i) {
                if (i >= currentIdx) return const SizedBox.shrink();
                final rLeft = i == currentIdx ? 26.0 : 20.0;
                final rRight = (i + 1) == currentIdx ? 26.0 : 20.0;
                final startX = 26.0 + (i * step) + rLeft;
                final endX = 26.0 + ((i + 1) * step) - rRight;
                final segWidth = (endX - startX).clamp(0.0, w);

                return Positioned(
                  left: startX,
                  width: segWidth,
                  top: 43.25,
                  child: Container(height: 1.5, color: AppColors.homeTimeLime),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_prayers.length, (i) {
                  final item = _prayers[i];
                  final time = timings[item.$1] ?? item.$3;
                  return HomePrayerStepItem(
                    time: time,
                    name: item.$1,
                    icon: item.$2,
                    isActive: i == currentIdx,
                    isPassed: i < currentIdx,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
