import 'package:flutter/material.dart';
import 'package:pokedx/screens/home.screen.dart';

class Routes {

  static get() {
    return <String, WidgetBuilder> {
      '/home' : (BuildContext context) => new HomeScreen(),
    };
  }

  static getHome() {
    return new HomeScreen();
  }
}