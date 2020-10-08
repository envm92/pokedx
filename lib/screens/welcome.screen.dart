import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('START'),
          onPressed: () =>  Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
    );
  }
  
}