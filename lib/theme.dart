import 'package:flutter/material.dart';

final ThemeData customTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = new ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Roboto'
  );
  return base.copyWith(
    primaryColor: Colors.red,
    accentColor: Colors.blue.shade600,
  );
}