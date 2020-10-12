import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StateChange extends AuthEvent {
  const StateChange(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class SignOutRequested extends AuthEvent{}