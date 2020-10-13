import 'package:equatable/equatable.dart';
import 'package:pokedx/models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class StateChange extends AuthEvent {
  const StateChange({this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class SignInRequested extends AuthEvent {
  const SignInRequested({this.user, this.password});

  final User user;
  final String password;

  @override
  List<Object> get props => [user, password];
}

class SignUpRequested extends AuthEvent {
  const SignUpRequested({this.user, this.password});

  final User user;
  final String password;

  @override
  List<Object> get props => [user, password];
}
class SignOutRequested extends AuthEvent {}