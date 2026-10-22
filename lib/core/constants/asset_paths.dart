/// Centralized asset path constants for SVGs and Images
class AssetPaths {
  const AssetPaths._();

  static const String _iconsBase = 'assets/icons';
  static const String _imagesBase = 'assets/images';

  // Branding & Logo
  static const String icDeenLogo = '$_iconsBase/ic_deen_logo.svg';
  static const String icGoogle = '$_iconsBase/ic_google.svg';
  static const String icApple = '$_iconsBase/ic_apple.svg';
  static const String successImage = '$_imagesBase/success_image.png';

  // Onboarding Background SVGs
  static const String imgOnboardingBgScreen2 =
      '$_imagesBase/secount_screen_image.svg';
  static const String imgOnboardingBgScreen3And4 =
      '$_imagesBase/3rd_and4th_screen_image.svg';

  // Navigation Icons (Figma node 1:1429 / 1:609)
  static const String icNavHome = '$_iconsBase/ic_nav_home.svg';
  static const String icNavCommunity = '$_iconsBase/ic_nav_community.svg';
  static const String icNavReflect = '$_iconsBase/ic_nav_reflect.svg';
  static const String icNavPrayer = '$_iconsBase/ic_nav_prayer.svg';
  static const String icNavProfile = '$_iconsBase/ic_nav_profile.svg';

  // Legacy navigation aliases
  static const String icHome = icNavHome;
  static const String icPrayer = icNavPrayer;
  static const String icReflect = icNavReflect;
  static const String icCommunity = icNavCommunity;
  static const String icProfile = icNavProfile;

  // Action & Status Icons
  static const String icNotification = '$_iconsBase/ic_notification.svg';
  static const String icLocation = '$_iconsBase/ic_location.svg';
  static const String icCheck = '$_iconsBase/ic_check.svg';
  static const String icStreak = '$_iconsBase/ic_streak.svg';
  static const String icBookmark = '$_iconsBase/ic_bookmark.svg';
  static const String icHeart = '$_iconsBase/ic_heart.svg';
  static const String icComment = '$_iconsBase/ic_comment.svg';
  static const String icShare = '$_iconsBase/ic_share.svg';
}
