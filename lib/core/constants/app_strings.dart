import 'package:deen_app/core/constants/strings/auth_strings.dart';
import 'package:deen_app/core/constants/strings/common_strings.dart';
import 'package:deen_app/core/constants/strings/home_strings.dart';
import 'package:deen_app/core/constants/strings/onboarding_strings.dart';

export 'package:deen_app/core/constants/strings/auth_strings.dart';
export 'package:deen_app/core/constants/strings/common_strings.dart';
export 'package:deen_app/core/constants/strings/home_strings.dart';
export 'package:deen_app/core/constants/strings/onboarding_strings.dart';

/// Centralized access point for all user-facing strings across the application.
class AppStrings {
  const AppStrings._();

  static const common = CommonStrings;
  static const onboarding = OnboardingStrings;
  static const auth = AuthStrings;
  static const home = HomeStrings;
}
