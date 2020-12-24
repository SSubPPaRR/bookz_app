import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth);

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed-in";
    } on FirebaseAuthException catch (e) {
      print("fbAuth: " + e.code);
      return e.code;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed-up";
    } on FirebaseAuthException catch (e) {
      print("fbAuth: " + e.code);
      return e.code;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
