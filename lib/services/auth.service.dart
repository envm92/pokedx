import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  Future<bool> isLogged() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getBool('isLogged');
    });
  }

  Future<bool> login() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.setBool('isLogged', true);
    });
  }

  Future<bool> logout() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.setBool('isLogged', false);
    });
  }
}