import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/screens/details_screen.dart';
import 'package:pokedx/screens/home_screen.dart';
import 'package:pokedx/screens/login_screen.dart';
import 'package:pokedx/screens/welcome_screen.dart';

class Routes {

  static Map get() {
    return <String, WidgetBuilder> {
      '/welcome' : (BuildContext context) => WelcomeScreen(),
      '/login' : (BuildContext context) => LoginScreen(),
      '/home' : (BuildContext context) => HomeScreen(),
      '/details' : (BuildContext context) => DetailsScreen(ModalRoute.of(context).settings.arguments),
    };
  }

  static StreamBuilder<User> getHome(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return StreamBuilder(
        stream: authBloc.authRepository.onAuthStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          authBloc.add(StateChange(snapshot.data));
          if(snapshot.hasData){
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        }
    );
  }
}