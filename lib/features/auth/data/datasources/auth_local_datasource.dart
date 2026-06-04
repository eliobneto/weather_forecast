import 'package:weather_forecast/core/api/secure_local_storage.dart';
import 'package:weather_forecast/core/definitions/types.dart';

class AuthLocalDatasource {
  AuthLocalDatasource({required this.storage});

  final ISecureLocalStorage storage;

  static const _credentialsKey = 'credentials';

  Future<Json?> readLocalCredentials() async {
    final data = await storage.read(_credentialsKey);
    if (data is! Json) return null;
    return data;
  }

  Future<void> writeLocalCredentials(Json credentials) async =>
      storage.write(_credentialsKey, credentials);

  Future<void> clearLocalCredentials() async => storage.delete(_credentialsKey);
}
