import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/auth/domain/abstractions/iauth_repository.dart';
import 'package:weather_forecast/features/auth/domain/models/auth_model.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';

class AuthUsecase {
  AuthUsecase({required this.authRepository});

  final IAuthRepository authRepository;

  AsyncResponse<UserModel> login({
    required String email,
    required String password,
  }) => authRepository.login(email: email, password: password);

  AsyncResponse<int> validate(String token) => authRepository.validate(token);

  AsyncResponse<void> logout() => authRepository.logout();

  Future<AuthModel?> readLocalCredentials() =>
      authRepository.readLocalCredentials();

  Future<void> writeLocalCredentials(AuthModel credentials) =>
      authRepository.writeLocalCredentials(credentials);

  void clearLocalCredentials() => authRepository.clearLocalCredentials();
}
