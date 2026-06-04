import 'package:dartz/dartz.dart';
import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:weather_forecast/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:weather_forecast/features/auth/domain/abstractions/iauth_repository.dart';
import 'package:weather_forecast/features/auth/domain/models/auth_model.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  @override
  AsyncResponse<UserModel> login({
    required String email,
    required String password,
  }) async {
    final body = {'email': email, 'password': password};

    final response = await remoteDatasource.login(body);

    return response.fold(
      Left.new,
      (success) => Right(UserModel.fromJson(success)),
    );
  }

  @override
  AsyncResponse<int> validate(String token) async {
    final response = await remoteDatasource.validate(token);

    return response.fold(Left.new, Right.new);
  }

  @override
  AsyncResponse<void> logout() async {
    final response = await remoteDatasource.logout();

    return response.fold(Left.new, Right.new);
  }

  @override
  Future<AuthModel?> readLocalCredentials() async {
    final data = await localDatasource.readLocalCredentials();
    if (data is! Json) return null;
    try {
      return AuthModel.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> writeLocalCredentials(AuthModel credentials) async =>
      localDatasource.writeLocalCredentials(credentials.toJson());

  @override
  Future<void> clearLocalCredentials() =>
      localDatasource.clearLocalCredentials();
}
