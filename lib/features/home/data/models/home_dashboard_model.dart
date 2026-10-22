import 'package:deen_app/features/home/data/models/user_location_model.dart';
import 'package:deen_app/features/home/domain/entities/home_dashboard_entity.dart';

/// Data transfer model for HomeDashboardEntity
class HomeDashboardModel extends HomeDashboardEntity {
  const HomeDashboardModel({
    super.location,
    super.hijriDate,
    super.gregorianDate,
    super.timings,
    super.nextPrayerName,
    super.nextPrayerTime,
    super.nextPrayerSecondsUntil,
    super.dailyGoalCompleted,
    super.dailyGoalTarget,
    super.streakCurrent,
    super.aiReflection,
    super.abundanceVerseArabic,
    super.abundanceVerseTranslation,
    super.abundanceVerseReference,
    super.isLocationRequired,
  });

  factory HomeDashboardModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final locJson = data['location'] as Map<String, dynamic>? ?? {};
    final dateJson = data['date'] as Map<String, dynamic>? ?? {};
    final hijri = dateJson['hijri'] as Map<String, dynamic>? ?? {};
    final greg = dateJson['gregorian'] as Map<String, dynamic>? ?? {};

    final timingsMap = <String, String>{};
    if (data['timings'] is Map) {
      (data['timings'] as Map).forEach((k, v) {
        timingsMap[k.toString()] = v?.toString() ?? '';
      });
    }

    final nextP = data['next_prayer'] as Map<String, dynamic>? ?? {};
    final goal = data['daily_goal'] as Map<String, dynamic>? ?? {};
    final streak = data['streak'] as Map<String, dynamic>? ?? {};
    final reflection = data['ai_reflection'] as Map<String, dynamic>? ?? {};
    final verse = data['abundance_verse'] as Map<String, dynamic>? ?? {};

    final hijriDay = hijri['day'];
    final hijriMonth = hijri['month_en'];
    final hijriYear = hijri['year'];
    final hijriStr = (hijriDay != null && hijriMonth != null && hijriYear != null)
        ? '$hijriDay $hijriMonth, $hijriYear H'
        : (hijri['date'] as String? ?? '');

    final gregWeekday = greg['weekday_en'];
    final gregDate = greg['date'];
    final gregStr = (gregWeekday != null && gregDate != null)
        ? '$gregWeekday, $gregDate'
        : (gregDate as String? ?? '');

    final statusStr = data['status'] as String? ?? json['status'] as String? ?? '';
    final isLocRequired = statusStr == 'UPDATE_LOCATION_REQUIRED';

    return HomeDashboardModel(
      location: UserLocationModel.fromJson(locJson),
      hijriDate: hijriStr,
      gregorianDate: gregStr,
      timings: timingsMap,
      nextPrayerName: nextP['name'] as String? ?? '',
      nextPrayerTime: nextP['at'] as String? ?? '',
      nextPrayerSecondsUntil: nextP['seconds_until'] as int? ?? 0,
      dailyGoalCompleted: goal['completed'] as int? ?? 0,
      dailyGoalTarget: goal['target'] as int? ?? 5,
      streakCurrent: streak['current'] as int? ?? 0,
      aiReflection: reflection['text'] as String? ?? '',
      abundanceVerseArabic: verse['arabic'] as String? ?? '',
      abundanceVerseTranslation: verse['translation'] as String? ?? '',
      abundanceVerseReference: verse['reference'] as String? ?? '',
      isLocationRequired: isLocRequired,
    );
  }
}
