part of 'auth_credentials_cubit.dart';

abstract class AuthCredentialsState {
  const AuthCredentialsState();
}

class AuthCredentialsIdleState extends AuthCredentialsState {
  const AuthCredentialsIdleState();
}

class AuthCredentialsLoadingState extends AuthCredentialsState {
  const AuthCredentialsLoadingState();
}

class AuthCredentialsSuccessState extends AuthCredentialsState {
  AuthCredentialsSuccessState({required this.credentials});

  final AuthModel? credentials;
}
