enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  AuthenticationStatus status = AuthenticationStatus.unknown;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    status = AuthenticationStatus.authenticated;

    return true;
  }

  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    status = AuthenticationStatus.unauthenticated;
  }
}
