/// Global Application Constants
class AppConstants {
  const AppConstants._();

  static const String appName = 'Deen';
  static const String appVersion = '1.0.0';
  static const String fontInter = 'Inter';
  static const String fontAmiri = 'Amiri';

  // API Config
  static const String defaultBaseUrl = 'https://test.deenstep.com';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Storage Keys
  static const String tokenKey = 'deen_auth_token';
  static const String refreshTokenKey = 'deen_refresh_token';
  static const String userKey = 'deen_user_data';
  static const String isFirstTimeKey = 'deen_is_first_time';
}
