/// Centralized catalog of all route paths and route names.
/// No hardcoded route strings should be used anywhere in widgets.
class AppRoutes {
  const AppRoutes._();

  // Root & Onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/auth/login';
  static const String signUp = '/auth/sign-up';
  static const String otpVerification = '/auth/otp-verification';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPasswordOtp = '/auth/reset-password-otp';
  static const String setNewPassword = '/auth/set-new-password';
  static const String registrationSuccess = '/auth/registration-success';
  static const String tooManyAttempts = '/auth/too-many-attempts';

  // Dashboard & Main Tabs
  static const String dashboard = '/dashboard';
  static const String home = '/dashboard/home';
  static const String prayer = '/dashboard/prayer';
  static const String reflect = '/dashboard/reflect';
  static const String community = '/dashboard/community';
  static const String profile = '/dashboard/profile';

  // Community Details
  static const String communityDetail = '/community/detail';
  static const String createPost = '/community/create-post';

  // Platform
  static const String privacyPolicy = '/platform/privacy-policy';
  static const String termsAndConditions = '/platform/terms-and-conditions';
}
