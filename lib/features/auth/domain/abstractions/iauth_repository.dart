import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/auth/domain/models/auth_model.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';

abstract class IAuthRepository {
  AsyncResponse<UserModel> login({
    required String email,
    required String password,
  });

  AsyncResponse<int> validate(String token);

  AsyncResponse<void> logout();

  Future<AuthModel?> readLocalCredentials();

  Future<void> writeLocalCredentials(AuthModel credentials);

  Future<void> clearLocalCredentials();
}
