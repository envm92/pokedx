import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedx/models/user.dart' as model;

class AuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) {
    return
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
  }

  model.User getUser() {
    var currAuthUser = _firebaseAuth.currentUser;
    return model.User(currAuthUser.uid, currAuthUser.email);
  }

  Future<UserCredential> signIn (String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Stream<User> onAuthStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}