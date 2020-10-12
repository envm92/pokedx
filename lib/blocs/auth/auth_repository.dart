import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedx/providers/auth_provider.dart';

class AuthRepository {
  final authProvider = AuthProvider();

  Future<void> signIn (String email, String password) {
    return authProvider.signIn(email, password);
  }

  Future<void> signUp (String email, String password) {
    return authProvider.signUp(email, password);
  }

  Future<void> signOut () {
    return authProvider.signOut();
  }

  Stream<User> onAuthStateChanges() {
    return authProvider.onAuthStateChanges();
  }
}