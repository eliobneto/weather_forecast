import 'package:weather_forecast/core/api/secure_local_storage.dart';
import 'package:weather_forecast/core/definitions/types.dart';

class UserLocalDatasource {
  UserLocalDatasource({required this.storage});

  final ISecureLocalStorage storage;

  static const _userKey = 'user';

  Future<Json?> readLocalUser() async {
    final data = await storage.read(_userKey);
    if (data is! Json) return null;
    return data;
  }

  Future<void> writeLocalUser(Json user) async => storage.write(_userKey, user);

  Future<void> clearLocalUser() async => storage.delete(_userKey);
}
