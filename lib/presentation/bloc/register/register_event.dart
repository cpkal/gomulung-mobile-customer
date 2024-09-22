part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterServiceSelected extends RegisterEvent {
  final String service_type;

  RegisterServiceSelected(this.service_type);

  @override
  List<Object> get props => [service_type];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String phoneNumber;
  final String password;
  final String name;

  RegisterSubmitted(this.email, this.phoneNumber, this.password, this.name);

  @override
  List<Object> get props => [email, phoneNumber, password, name];
}

class RegisterVerifyEmail extends RegisterEvent {
  final String email;
  final String otp;

  RegisterVerifyEmail(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}
