import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';


class MyAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> getCurrentUser() async {
    return _auth.currentUser();
  }

  Future<FirebaseUser> signInWithGoogle() async {
    // Attempt to get the currently authenticated user
    GoogleSignInAccount googleUser = _googleSignIn.currentUser;

    if (googleUser == null) {
      // Force the user to interactively sign in
      googleUser = await _googleSignIn.signIn();
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Authenticate with firebase
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    assert(user != null);
    assert(!user.isAnonymous);

    return user;
  }

  signOut() async {
//Delete all records from local

/*     var albumsBL = new AlbumsBL();
    albumsBL.removeLocalStoredDB();
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await _googleSignIn.signOut(); */
  }

  Future<FirebaseUser> signUpWithEmail(String email, String password) async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password)).user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }

  Future<AuthenticationObject> signInWithEmail(
      String email, String password) async {
    var authObj = new AuthenticationObject();
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      authObj.user = user;
    } catch (error) {
      authObj.error = error;
      return authObj;
    }
    return authObj;
  }
}

class AuthenticationObject {
  FirebaseUser user;
  Exception error;
}
