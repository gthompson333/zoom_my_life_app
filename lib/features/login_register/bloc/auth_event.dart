part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginAuthEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class CreateUserEvent extends AuthEvent {
  final String email;
  final String password;

  const CreateUserEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutAuthEvent extends AuthEvent {}
