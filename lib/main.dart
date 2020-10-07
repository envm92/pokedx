import 'package:flutter/material.dart';
import 'package:pokedx/routes.dart';
import 'package:pokedx/theme.dart';

void main() {
  runApp(new PokedxApp());
}

class PokedxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: customTheme,
        routes: Routes.get(),
        home: Routes.getHome()
    );
  }
}