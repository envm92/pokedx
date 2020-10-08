import 'package:flutter/material.dart';
import 'package:pokedx/screens/details.screen.dart';
import 'package:pokedx/screens/home.screen.dart';

class Routes {

  static get() {
    return <String, WidgetBuilder> {
      '/home' : (BuildContext context) => new HomeScreen(),
      '/details' : (BuildContext context) => new DetailsScreen(ModalRoute.of(context).settings.arguments),
    };
  }

  static getHome() {
    return new HomeScreen();
  }
}