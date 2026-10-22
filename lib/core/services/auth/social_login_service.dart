import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthCanceledException implements Exception {
  const SocialAuthCanceledException([this.message = 'Sign-in canceled']);
  final String message;
  @override
  String toString() => message;
}

class SocialLoginResult {
  const SocialLoginResult({
    required this.idToken,
    required this.provider,
    this.email,
    this.displayName,
    this.credential,
  });

  final String idToken;
  final String provider;
  final String? email;
  final String? displayName;
  final UserCredential? credential;
}

typedef GoogleLoginResponse = SocialLoginResult;
typedef AppleLoginResponse = SocialLoginResult;

Future<SocialLoginResult> googleLoginService() async {
  try {
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    if (googleAuth.idToken == null) throw Exception('Google ID Token not found');

    final cred = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    final userCred = await FirebaseAuth.instance.signInWithCredential(cred);
    final firebaseUser = userCred.user;
    if (firebaseUser == null) throw Exception('Firebase user not found');

    final fbIdToken = await firebaseUser.getIdToken(true);
    if (fbIdToken == null || fbIdToken.isEmpty) {
      throw Exception('Failed to obtain Firebase ID token');
    }

    return SocialLoginResult(
      idToken: fbIdToken,
      provider: 'google',
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      credential: userCred,
    );
  } on FirebaseAuthException {
    rethrow;
  } on FirebaseException {
    rethrow;
  } catch (e) {
    final str = e.toString().toLowerCase();
    if (str.contains('cancel') || str.contains('abort')) {
      throw const SocialAuthCanceledException();
    }
    rethrow;
  }
}

Future<SocialLoginResult> appleLoginService() async {
  try {
    final apple = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );
    if (apple.identityToken == null) throw Exception('Apple Identity Token not found');

    final cred = OAuthProvider('apple.com').credential(
      idToken: apple.identityToken,
      accessToken: apple.authorizationCode,
    );
    final userCred = await FirebaseAuth.instance.signInWithCredential(cred);
    final firebaseUser = userCred.user;
    if (firebaseUser == null) throw Exception('Firebase user not found');

    final fbIdToken = await firebaseUser.getIdToken(true);
    if (fbIdToken == null || fbIdToken.isEmpty) {
      throw Exception('Failed to obtain Firebase ID token');
    }

    return SocialLoginResult(
      idToken: fbIdToken,
      provider: 'apple',
      email: firebaseUser.email ?? apple.email,
      displayName: firebaseUser.displayName,
      credential: userCred,
    );
  } catch (e) {
    final str = e.toString().toLowerCase();
    if (str.contains('cancel') || str.contains('abort')) {
      throw const SocialAuthCanceledException();
    }
    rethrow;
  }
}
