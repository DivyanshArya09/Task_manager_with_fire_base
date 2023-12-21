import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user_model.dart';

class AuthService {
  static String? userName = '';
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  User? _userFromFirebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebaseUser(credential.user);
  }

  Future<String?> getToken() async {
    return _auth.currentUser!.email;
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebaseUser(credential.user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
