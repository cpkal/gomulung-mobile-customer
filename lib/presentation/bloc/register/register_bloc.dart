import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/customer.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterVerifyEmail>(_onRegisterVerifyEmail);
  }

  void _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    await ApiService.postData('/auth/register', {
      'email': event.email,
      'phone_number': event.phoneNumber,
      'password': event.password,
      'name': event.name,
    }).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailed());
      }
    }).catchError((e) {
      print(e);
      emit(RegisterFailed());
    });
  }

  void _onRegisterVerifyEmail(
    RegisterVerifyEmail event,
    Emitter<RegisterState> emit,
  ) {
    // emit(state.copyWith(email: event.email));
    print("RegisterBloc: _onRegisterVerifyEmail: email: ${event.email}");
  }
}
