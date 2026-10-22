import 'package:deen_app/features/home/domain/entities/user_location_entity.dart';
import 'package:equatable/equatable.dart';

/// Aggregated domain entity for the Home Screen dashboard
class HomeDashboardEntity extends Equatable {
  const HomeDashboardEntity({
    this.location = const UserLocationEntity(),
    this.hijriDate = '',
    this.gregorianDate = '',
    this.timings = const {},
    this.nextPrayerName = '',
    this.nextPrayerTime = '',
    this.nextPrayerSecondsUntil = 0,
    this.dailyGoalCompleted = 0,
    this.dailyGoalTarget = 5,
    this.streakCurrent = 0,
    this.aiReflection = '',
    this.abundanceVerseArabic = '',
    this.abundanceVerseTranslation = '',
    this.abundanceVerseReference = '',
  });

  final UserLocationEntity location;
  final String hijriDate;
  final String gregorianDate;
  final Map<String, String> timings;
  final String nextPrayerName;
  final String nextPrayerTime;
  final int nextPrayerSecondsUntil;
  final int dailyGoalCompleted;
  final int dailyGoalTarget;
  final int streakCurrent;
  final String aiReflection;
  final String abundanceVerseArabic;
  final String abundanceVerseTranslation;
  final String abundanceVerseReference;

  @override
  List<Object?> get props => [
    location,
    hijriDate,
    gregorianDate,
    timings,
    nextPrayerName,
    nextPrayerTime,
    nextPrayerSecondsUntil,
    dailyGoalCompleted,
    dailyGoalTarget,
    streakCurrent,
    aiReflection,
    abundanceVerseArabic,
    abundanceVerseTranslation,
    abundanceVerseReference,
  ];
}
