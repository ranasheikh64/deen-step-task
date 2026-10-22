import 'package:deen_app/core/constants/asset_paths.dart';
import 'package:deen_app/core/theme/app_colors.dart';
import 'package:deen_app/features/home/presentation/widgets/home_active_prayer_item.dart';
import 'package:deen_app/features/home/presentation/widgets/home_prayer_timeline_item.dart';
import 'package:flutter/material.dart';

/// Prayer timeline row displaying the 5 daily prayer times (Figma node 1:416).
class HomePrayerTimelineRow extends StatelessWidget {
  const HomePrayerTimelineRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 28,
            right: 200,
            top: 46,
            child: Container(height: 1, color: AppColors.primary),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              HomePrayerTimelineItem(
                time: '04:03',
                name: 'Fajr',
                icon: AssetPaths.icPrayerFajr,
                completed: true,
              ),
              HomeActivePrayerItem(
                time: '11.37',
                name: 'Dhuhr',
                icon: AssetPaths.icPrayerDhuhr,
              ),
              HomePrayerTimelineItem(
                time: '15:00',
                name: 'Asr',
                icon: AssetPaths.icPrayerAsr,
              ),
              HomePrayerTimelineItem(
                time: '17:48',
                name: 'Maghrib',
                icon: AssetPaths.icPrayerMaghrib,
              ),
              HomePrayerTimelineItem(
                time: '19:02',
                name: 'Isha',
                icon: AssetPaths.icPrayerFajr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
