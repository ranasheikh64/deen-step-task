/// Calculates the remaining countdown string to the next prayer
String formatPrayerCountdown(String prayerName, String prayerTime) {
  if (prayerTime.isEmpty || prayerName.isEmpty) return '';
  final parts = prayerTime.split(':');
  if (parts.length < 2) return '';
  final h = int.tryParse(parts[0]) ?? 0;
  final m = int.tryParse(parts[1]) ?? 0;
  final now = DateTime.now();
  var target = DateTime(now.year, now.month, now.day, h, m);
  if (target.isBefore(now)) target = target.add(const Duration(days: 1));
  final diff = target.difference(now);
  return '$prayerName in ${diff.inHours}h ${diff.inMinutes % 60}m left';
}
