part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String token;

  AuthenticationLoggedIn(this.token);

  @override
  List<Object> get props => [token];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
