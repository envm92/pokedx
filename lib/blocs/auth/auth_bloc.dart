import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/blocs/auth/auth_repository.dart';
import 'package:pokedx/blocs/auth/auth_state.dart';
import 'package:pokedx/models/user.dart' as model;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({@required this.authRepository}): assert(authRepository != null), super(UnknownState());

  Stream<User> get authState => authRepository.onAuthStateChanges();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is StateChange) {
        if (event.user != null) {
          yield AuthenticatedState(model.User(event.user.uid, event.user.email));
        } else {
          yield UnauthenticatedState();
        }
    }
    if (event is SignInRequested) {
      yield RequestChangeState();
      try {
        await authRepository.signIn(event.email, event.password);
      } catch (err) {
        yield ErrorState(err.message);
      }
    }
    if (event is SignUpRequested) {
      yield RequestChangeState();
      try {
        await authRepository.signUp(event.email, event.password);
        yield SignUpSuccess();
      } catch (err) {
        yield SignUpError(err.message);
      }
    }
    if (event is SignOutRequested) {
      yield RequestChangeState();
      await authRepository.signOut();
      yield UnauthenticatedState();
    }
  }
}