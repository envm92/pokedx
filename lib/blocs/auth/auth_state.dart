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

class ErrorState extends AuthState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
class SignUpError extends ErrorState{
  SignUpError(String message) : super(message);
}
class SignUpSuccess extends AuthState {}
class RequestChangeState extends AuthState {}
class UnauthenticatedState extends AuthState {}
class UnknownState extends AuthState {}