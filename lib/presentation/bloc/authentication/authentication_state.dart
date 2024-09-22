part of 'authentication_bloc.dart';

final class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.customer = null,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(Customer customer)
      : this._(status: AuthenticationStatus.authenticated, customer: customer);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final Customer? customer;

  @override
  List<Object> get props => [status, customer ?? ''];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial() : super.unknown();
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading() : super.unknown();
}

final class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated(Customer customer)
      : super.authenticated(customer);
}
