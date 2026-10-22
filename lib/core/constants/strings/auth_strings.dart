/// User-facing string constants for authentication flows.
class AuthStrings {
  const AuthStrings._();

  // Login
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle =
      'Enter your details to access your Deen-step habits.';
  static const String email = 'Email Address';
  static const String emailHint = 'Enter your email';
  static const String emailPlaceholder = 'name@example.com';
  static const String password = 'Password';
  static const String passwordHint = 'Enter your password';
  static const String passwordCreateHint = 'Create a password';
  static const String forgotPassword = 'Forgot password?';
  static const String login = 'Log In';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signUp = 'Sign Up';
  static const String logInWith = 'Log In With';
  static const String continueAsGuest = 'Continue as Guest';
  static const String or = 'OR';

  // Registration
  static const String createAccount = 'Create Account';
  static const String registerSubtitle =
      'Start your consistent steps towards spiritual growth.';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'Enter your full name';
  static const String confirmPassword = 'Confirm Password';
  static const String confirmPasswordHint = 'Confirm your password';
  static const String registerAccount = 'Register Account';
  static const String haveAnAccount = 'Have an account? ';
  static const String agreeToThe = 'I agree to the ';
  static const String privacyPolicy = 'Privacy Policy';
  static const String and = ' and ';
  static const String terms = 'Terms';
  static const String clickHereToRead = '.\nClick here to Read.';

  // OTP Verification
  static const String verifyEmail = 'Verify Email';
  static const String otpSentTo = "We've sent a 4-digit verification code to\n";
  static const String verify = 'Verify';
  static const String didNotReceiveCode = "Didn't receive code? ";
  static const String resendIn = 'Resend in ';
  static const String resendCode = 'Resend Code';
  static const String incorrectCodePrefix = 'Incorrect Code : ';
  static const String attemptsRemainingSuffix = ' attempts remaining.';
  static const String codeResentSuccess = 'Verification code resent';

  // Lockout
  static const String tooManyAttempts = 'Too Many Attempts';
  static const String timeRemaining = 'TIME REMAINING';
  static const String lockoutDescription =
      "We've detected too many incorrect verification attempts. "
      "For your account's security, further attempts have been "
      'temporarily blocked.';
  static const String needHelp = 'Need help? ';
  static const String contactSupport = 'Contact Support';
  static const String supportContactInfo =
      'Support contact: support@deenstep.com';

  // Success
  static const String registrationSuccess = 'Registration Successful';
  static const String registrationSuccessMessage =
      'Your account has been created successfully. Welcome to Deen.';
  static const String goToHome = 'Go to Home';
}
