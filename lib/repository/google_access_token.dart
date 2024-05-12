import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAccessToken {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication googleAuth =
            await account.authentication;
        // Access token is stored in googleAuth.accessToken
        final String accessToken = googleAuth.accessToken!;
        return accessToken;
      }
    } catch (error) {
      log(error.toString());
      print('Error signing in with Google: $error');
      return null;
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
  }
}
