part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = "",
    this.password = "",
    this.failureMessage = '',
  });

  final FormzSubmissionStatus status;
  final String email;
  final String password;
  final String failureMessage;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    String? email,
    String? password,
    String? failureMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
        password,
        failureMessage,
      ];
}
