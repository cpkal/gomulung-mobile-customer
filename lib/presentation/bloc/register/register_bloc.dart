import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/model/data/customer.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterServiceSelected>(_onRegisterServiceSelected);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterVerifyEmail>(_onRegisterVerifyEmail);
  }

  void _onRegisterServiceSelected(
    RegisterServiceSelected event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(serviceType: event.service_type));
    print(
        "RegisterBloc: _onRegisterServiceSelected: serviceType: ${event.service_type}");
  }

  void _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    print(
        "RegisterBloc: _onRegisterSubmitted: name: ${event.name}, email: ${event.email}, password: ${event.password}");
  }

  void _onRegisterVerifyEmail(
    RegisterVerifyEmail event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(email: event.email));
    print("RegisterBloc: _onRegisterVerifyEmail: email: ${event.email}");
  }
}
