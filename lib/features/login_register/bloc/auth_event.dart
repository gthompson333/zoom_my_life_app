part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoggedInAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const LoggedInAuthEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class UserCreatedAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const UserCreatedAuthEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LoggedOutAuthEvent extends AuthEvent {}

class AuthStatusChangedAuthEvent extends AuthEvent {
  final bool isAuthenticated;

  const AuthStatusChangedAuthEvent(this.isAuthenticated);

  @override
  List<Object> get props => [isAuthenticated];
}
