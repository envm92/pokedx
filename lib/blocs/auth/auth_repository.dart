import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedx/providers/auth_provider.dart';
import 'package:pokedx/models/user.dart' as model;

class AuthRepository {
  final authProvider = AuthProvider();
  model.User user;

  Future<UserCredential> signIn (model.User user, String password) {
    return authProvider.signIn(user.email, password);
  }

  Future<UserCredential> signUp (model.User user, String password) {
    return authProvider.signUp(user.email, password);
  }

  Future<void> signOut () {
    return authProvider.signOut();
  }

  Stream<User> onAuthStateChanges() {
    return authProvider.onAuthStateChanges();
  }

  model.User getUser() {
    return user;
  }

  void setUser(model.User newUser) {
    user = newUser;
  }
}