import 'package:zoom_my_life_app/shared/exports.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isAuthenticated = false;

  FirebaseAuthService() {
    _listenForAuthStateChanges();
  }

  @override
  Stream<bool> authStateChanged() async* {
    yield _isAuthenticated;
  }

  @override
  Future<UserCredential> signIn(String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(getErrorMessage(e.code));
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserCredential> createUser(String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(getErrorMessage(e.code));
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future signOut() async {
    return await _firebaseAuth.signOut();
  }

  void _listenForAuthStateChanges() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      // User is not authenticated.
      if (user == null) {
        _isAuthenticated = false;
      } else {
        _isAuthenticated = true;
      }
    });
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'Exception: wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'Exception: user-not-found':
        return 'No user found with this email. Please sign up.';
      case 'Exception: invalid-email':
        return 'This email does not exist';
      default:
        return 'An unexpected error occurred. Please try again later.';
    }
  }
}
