import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/blocs/auth/auth_repository.dart';
import 'package:pokedx/blocs/auth/auth_state.dart';
import 'package:pokedx/models/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({@required this.authRepository}): assert(authRepository != null), super(UnknownState());


  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is StateChange) {
        if (event.user != null) {
          yield AuthenticatedState(User(event.user.uid, event.user.email));
        } else {
          yield UnauthenticatedState();
        }
    }
    if (event is SignOutRequested) {
      await authRepository.signOut();
      yield UnauthenticatedState();
    }
  }
}