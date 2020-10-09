import 'package:flutter/material.dart';

final ThemeData customTheme = _buildTheme();

ThemeData _buildTheme() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    primaryColor: Colors.red,
    accentColor: Colors.blue.shade600,
  );
}