part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? name;

  RegisterInitial({this.email, this.phoneNumber, this.password, this.name});
}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailed extends RegisterState {}
