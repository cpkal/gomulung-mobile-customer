import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:las_customer/model/repository/authentication_repository.dart';
import 'package:las_customer/presentation/bloc/authentication/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      print('LoginBloc: _onLoginSubmitted: email: ${event}');
      final isAuthenticated = await _authenticationRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));

      if (isAuthenticated) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          failureMessage: 'Invalid email or password',
        ));
      }
    } on SocketException {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        failureMessage: 'No Internet Connection',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        failureMessage: e.toString(),
      ));
    }
  }
}
