part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.name = "",
    this.email = "",
    this.password = "",
    this.serviceType = "",
  });

  final String name;
  final String email;
  final String password;
  final String serviceType;

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? serviceType,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  @override
  List<Object> get props => [
        name,
        email,
        password,
        serviceType,
      ];
}
