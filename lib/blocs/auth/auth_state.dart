import 'package:equatable/equatable.dart';
import 'package:pokedx/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  final User user;

  AuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}
class UnauthenticatedState extends AuthState {}
class UnknownState extends AuthState {}