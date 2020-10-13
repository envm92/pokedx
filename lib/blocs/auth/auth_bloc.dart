import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/blocs/auth/auth_repository.dart';
import 'package:pokedx/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({@required this.authRepository}): assert(authRepository != null), super(UnknownState());

  Stream<User> get authState => authRepository.onAuthStateChanges();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is StateChange) {
        if (event.user != null) {
          authRepository.setUser(event.user);
          yield AuthenticatedState(authRepository.getUser());
        } else {
          yield UnauthenticatedState();
        }
    }
    if (event is SignInRequested) {
      yield RequestChangeState();
      try {
        await authRepository.signIn(event.user, event.password);
      } catch (err) {
        yield ErrorState(err.message);
      }
    }
    if (event is SignUpRequested) {
      yield RequestChangeState();
      try {
        await authRepository.signUp(event.user, event.password);
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