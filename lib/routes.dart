import 'package:flutter/material.dart';
import 'package:pokedx/screens/details_screen.dart';
import 'package:pokedx/screens/home_screen.dart';
import 'package:pokedx/screens/login_screen.dart';
import 'package:pokedx/screens/welcome_screen.dart';
import 'package:pokedx/services/auth_service.dart';

class Routes {

  static Map get() {
    return <String, WidgetBuilder> {
      '/welcome' : (BuildContext context) => WelcomeScreen(),
      '/login' : (BuildContext context) => LoginScreen(),
      '/home' : (BuildContext context) => HomeScreen(),
      '/details' : (BuildContext context) => DetailsScreen(ModalRoute.of(context).settings.arguments),
    };
  }

  static FutureBuilder<bool> getHome() {
    var authSrv = AuthService();
    return FutureBuilder(
        future: authSrv.isLogged(),
        builder: (BuildContext context, AsyncSnapshot<bool> isLogged) {
          if (isLogged.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        }
    );
  }
}