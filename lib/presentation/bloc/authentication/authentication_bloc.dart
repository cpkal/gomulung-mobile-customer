import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/model/data/customer.dart';
import 'package:las_customer/model/repository/authentication_repository.dart';
import 'package:las_customer/model/repository/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required CustomerRepository customerRepository,
  })  : _authenticationRepository = authenticationRepository,
        _customerRepository = customerRepository,
        super(AuthenticationInitial()) {
    on<AuthenticationLoggedIn>(_onAuthenticationLoggedIn);
    on<AuthenticationLoggedOut>(_onAuthenticationLoggedOut);
  }

  final AuthenticationRepository _authenticationRepository;
  final CustomerRepository _customerRepository;
  Future<void> _onAuthenticationLoggedIn(
    AuthenticationLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {}

  Future<void> _onAuthenticationLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationRepository.logout();
    emit(const AuthenticationState.unauthenticated());
  }
}
