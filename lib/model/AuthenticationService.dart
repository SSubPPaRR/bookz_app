import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth);

  Future<String> signIn({String email, String password}) async {
    String isVerified = "Signed-in";
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userCred) => {
        if (!userCred.user.emailVerified)
          {signOut(), isVerified = "not-verified"}
      });

      return isVerified;
    } on FirebaseAuthException catch (e) {
      print("fbAuth: " + e.code);
      return e.code;
    }
  }

  Future<String> signUp({String email, String password}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      //create account
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCred) => {
                //create user in fireStore with empty shopping cart
                users
                    .doc(userCred.user.uid)
                    .set({'shoppingCart': []})
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error")),
                //send verification email
                if (!userCred.user.emailVerified)
                  {userCred.user.sendEmailVerification(), signOut()}
              });

      return 'signed-up';
    } on FirebaseAuthException catch (e) {
      print("fbAuth: " + e.code);
      return e.code;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void sendVerification(String email, String password) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCred) => {
      if (!userCred.user.emailVerified)
        {
          userCred.user.sendEmailVerification(),
          signOut(),
        }
    });
  }
}
