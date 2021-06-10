import 'package:bookclub/models/authmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<AuthModel> get user {
    return _auth.authStateChanges().map((User firebaseUser) =>
        (firebaseUser != null)
            ? AuthModel.fromFirebaseUser(user: firebaseUser)
            : null);
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signupUser(
      String email, String password, String fullName) async {
    String retVal = "error";
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      retVal = "success";
    } catch (e) {
      retVal = e.message;
    }

    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignin = GoogleSignIn(scopes: [
      'email',
      'https://wwww.googleapis.com/auth/contacts.readonly'
    ]);
    try {
      GoogleSignInAccount _googleUser = await _googleSignin.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo.isNewUser) {
        //MyDatabase().createUser(_user);
      }
      // _currentUser = await MyDatabase().getUserInfo(_authResult.user.uid);
      // if (_currentUser != null) {
      retVal = "success";
      // }
    } catch (e) {
      retVal = e.message;
    }

    return retVal;
  }
}
