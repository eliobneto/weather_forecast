import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/features/auth/domain/models/auth_model.dart';
import 'package:weather_forecast/features/auth/domain/usecases/auth_usecase.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';
import 'package:weather_forecast/features/user/domain/usecases/user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authUsecase, required this.userUsecase})
    : super(AuthIdleState());

  final AuthUsecase authUsecase;
  final UserUsecase userUsecase;

  Future<void> login({
    required String email,
    required String password,
    required bool saveCredentials,
  }) async {
    emit(const AuthLoadingState());

    final response = await authUsecase.login(email: email, password: password);

    return response.fold((error) => emit(AuthFailState(error: error)), (
      user,
    ) async {
      await userUsecase.writeLocalUser(user);

      await authUsecase.writeLocalCredentials(
        AuthModel(
          email: email,
          password: password,
          showCredentials: saveCredentials,
        ),
      );

      return emit(AuthSuccessState(user: user));
    });
  }

  Future<void> reauth() async {
    emit(const AuthLoadingState());

    final user = await userUsecase.readLocalUser();

    if (user == null) {
      return emit(const AuthExpiredState());
    }

    final response = await authUsecase.validate(user.token);

    return response.fold((_) => emit(const AuthExpiredState()), (exp) async {
      final tokenLife = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

      if (tokenLife.isBefore(DateTime.now())) {
        emit(const AuthExpiredState());

        await userUsecase.clearLocalUser();

        return;
      }

      return emit(AuthSuccessState(user: user));
    });
  }

  Future<void> logout() async {
    emit(const AuthLogoutState());

    await authUsecase.logout();

    userUsecase.clearLocalUser();
  }
}
