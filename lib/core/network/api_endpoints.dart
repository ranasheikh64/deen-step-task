/// Complete catalog of backend API endpoints according to OpenAPI specification
class ApiEndpoints {
  const ApiEndpoints._();

  // Auth & Account
  static const String guestLogin = '/auth/guest/login/';
  static const String login = '/auth/login/';
  static const String logout = '/auth/logout/';
  static const String refreshToken = '/auth/refresh-token/';
  static const String signUp = '/auth/sign-up/';
  static const String signUpVerify = '/auth/sign-up/verify/';
  static const String socialLogin = '/auth/social/login/';
  static const String socialSignUp = '/auth/social/sign-up/';

  // Password Management
  static const String resetOtpRequest =
      '/password-management/reset-otp-request/';
  static const String resetOtpVerify =
      '/password-management/reset-otp-request/verify/';
  static const String setNewPassword =
      '/password-management/reset-otp-request/set-new-password/';

  // User Profile & Settings
  static const String userDashboard = '/user/dashboard/';
  static const String userCurrentLocation = '/user/current/location/';
  static const String userLocationUpdate = '/user/location/update/';
  static const String userProfile = '/user/profile/';
  static const String userProfileUpdate = '/user/profile/update/';
  static const String userSettingsSummary = '/user/settings/summary/';
  static const String userHijriCalendar = '/user/hijri-calendar/';
  static const String userMonthlyReview = '/user/profile/monthly-review/';
  static const String userPrayerCalcMethods =
      '/user/profile/prayer/calculation/method/list/';
  static const String userPrayerCalcUpdate =
      '/user/profile/prayer/calculation/method/update/';
  static const String userAsrMethods = '/user/profile/prayer/asr-method/list/';
  static const String userAsrMethodUpdate =
      '/user/profile/prayer/asr-method/update/';
  static const String userNotificationToggle =
      '/user/profile/notification/setting/update/toggle/';

  // Prayer
  static const String prayerToday = '/prayer/today/';
  static const String prayerLog = '/prayer/log/';
  static const String prayerStreak = '/prayer/streak/';
  static const String prayerHistory = '/prayer/history/';
  static const String prayerReminder = '/prayer/reminder/';

  // Reflect
  static const String reflectSummary = '/reflect/summary/';
  static const String reflectMoodCheckIn = '/reflect/mood/check-in/';
  static const String reflectMoodTimeline = '/reflect/mood/timeline/';
  static const String reflectGratitude = '/reflect/gratitude/';
  static const String reflectJournal = '/reflect/journal/';
  static const String reflectFeed = '/reflect/feed/';

  // Community
  static const String communityList = '/community/list/';
  static const String communityPosts = '/community/posts/';
  static const String communityPostsRealtime = '/community/posts/realtime/';
  static const String communityPostsSaved = '/community/posts/saved/';
  static const String communityJoin = '/community/join/';
  static const String communityNotifications = '/community/notifications/';

  // Platform
  static const String privacyPolicy = '/platform/privacy-policy/';
  static const String termsAndConditions = '/platform/terms-and-conditions/';
}
