import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/core/util/secure_storage.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SecureStorage _secureStorage = SecureStorage();

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    await ApiService.postData('/auth/login', {
      'email': event.email,
      'password': event.password,
    }).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var token = jsonDecode(res.body)["token"];

        _secureStorage.writeSecureData(key: 'token', value: token);
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    }).catchError((e) {
      emit(LoginFailed());
    });
  }
}
