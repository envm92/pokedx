import 'package:flutter/material.dart';
import 'package:pokedx/screens/details.screen.dart';
import 'package:pokedx/screens/home.screen.dart';
import 'package:pokedx/screens/login.screen.dart';
import 'package:pokedx/screens/welcome.screen.dart';
import 'package:pokedx/services/auth.service.dart';

class Routes {

  static get() {
    return <String, WidgetBuilder> {
      '/welcome' : (BuildContext context) => WelcomeScreen(),
      '/login' : (BuildContext context) => LoginScreen(),
      '/home' : (BuildContext context) => HomeScreen(),
      '/details' : (BuildContext context) => DetailsScreen(ModalRoute.of(context).settings.arguments),
    };
  }

  static getHome() {
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