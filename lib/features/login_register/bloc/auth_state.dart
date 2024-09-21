part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class IsAuthenticatedAuthState extends AuthState {}

final class IsNotAuthenticatedAuthState extends AuthState {}

final class AuthenticationInProgressAuthState extends AuthState {}

final class AuthenticationFailedAuthState extends AuthState {}


