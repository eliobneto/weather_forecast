import 'package:weather_forecast/features/user/domain/models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel?> readLocalUser();

  Future<void> writeLocalUser(UserModel user);

  Future<void> clearLocalUser();
}
