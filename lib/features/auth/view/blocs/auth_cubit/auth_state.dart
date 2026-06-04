part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

abstract class UnauthenticatedState extends AuthState {
  const UnauthenticatedState();
}

class AuthIdleState extends UnauthenticatedState {}

class AuthExpiredState extends UnauthenticatedState {
  const AuthExpiredState();
}

class AuthLogoutState extends UnauthenticatedState {
  const AuthLogoutState();
}

class AuthSuccessState extends AuthState {
  AuthSuccessState({required this.user});

  final UserModel user;
}

class AuthFailState extends AuthState {
  AuthFailState({required this.error});

  final ErrorModel error;
}
