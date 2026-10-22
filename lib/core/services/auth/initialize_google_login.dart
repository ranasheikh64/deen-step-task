import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn.instance;

Future<void> initGoogleSignIn() async {
  debugPrint('Google Sign In initialize start');
  await googleSignIn.initialize(
    serverClientId: '176098675776-5ftvp14u8ijnv8348oj6jtv3johiosaf.apps.googleusercontent.com',
  );
  debugPrint('Google Sign In initialized ');
}
