import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/screens/details_screen.dart';
import 'package:pokedx/screens/home_screen.dart';
import 'package:pokedx/screens/sign_in_screen.dart';
import 'package:pokedx/screens/sign_up_screen.dart';
import 'package:pokedx/screens/welcome_screen.dart';
import 'package:pokedx/models/user.dart' as model;

class Routes {

  static Map get() {
    return <String, WidgetBuilder> {
      '/sign_in' : (BuildContext context) => SignInScreen(),
      '/sign_up' : (BuildContext context) => SignUpScreen(),
      '/welcome' : (BuildContext context) => WelcomeScreen(),
      '/home' : (BuildContext context) => HomeScreen(),
      '/details' : (BuildContext context) => DetailsScreen(),
    };
  }

  static StreamBuilder<User> getHome(BuildContext context) {
    return StreamBuilder(
        stream: BlocProvider.of<AuthBloc>(context).authState,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          var user = (snapshot.hasData) ? model.User(snapshot.data.uid, snapshot.data.email) : null;
          BlocProvider.of<AuthBloc>(context).add(StateChange(user: user));
          if(snapshot.hasData){
            return HomeScreen();
          } else {
            return SignInScreen();
          }
        }
    );
  }
}