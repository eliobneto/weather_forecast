part of 'user_cubit.dart';

abstract class UserState {
  const UserState();
}

class UserIdleState extends UserState {
  const UserIdleState();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserSuccessState extends UserState {
  UserSuccessState({required this.user});

  final UserModel user;
}

class UserFailState extends UserState {
  UserFailState({required this.error});

  final ErrorModel error;
}
