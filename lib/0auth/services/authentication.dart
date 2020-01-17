import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizard/0auth/models/user.dart';

import 'database.dart';

abstract class BaseAuth {

  Future<String> signIn(String email, String password);

  Future signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    String username = getUsername(user.email);
    return user != null ? User(uid: user.uid, username: username) : null;
  }

  String getUsername(String email) {
    int end = email.indexOf("@");
    return email.substring(0, end);
  }

  // sign in with email and password
  Future<String> signIn(String email, String password) async {
    try {

      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return user.uid;

    } catch (error) {
      print(error.toString());
      return null;
    }

  }

  // register with email and password
  Future<User> signUp(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      String username = getUsername(user.email);

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateScoreData(username, 0);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }

  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

}
