import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/user/data/datasources/user_local_datasource.dart';
import 'package:weather_forecast/features/user/domain/abstractions/iuser_repository.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';

class UserRepository implements IUserRepository {
  UserRepository({required this.localDatasource});

  final UserLocalDatasource localDatasource;

  @override
  Future<UserModel?> readLocalUser() async {
    final data = await localDatasource.readLocalUser();
    if (data is! Json) return null;
    try {
      return UserModel.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> writeLocalUser(UserModel user) async =>
      localDatasource.writeLocalUser(user.toJson());

  @override
  Future<void> clearLocalUser() => localDatasource.clearLocalUser();
}
