import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/core/definitions/paths.dart';
import 'package:weather_forecast/core/definitions/types.dart';

class AuthRemoteDatasource {
  static const _secretKey = 'Of8i#EJf?m4eN@Fip!9WEfoIieE';

  Future<bool> _checkUser(Json data) async {
    final json = await rootBundle.loadString(Paths.userListMock);

    final userList = jsonDecode(json) as List;

    final user = userList.firstWhereOrNull(
      (value) => value['email'] == data['email'],
    );

    if (user == null) return false;

    final password = md5.convert(utf8.encode(data['password'])).toString();

    if (password != user['password']) return false;

    return true;
  }

  AsyncResponse<Json> login(Json data) async {
    try {
      final userExist = await _checkUser(data);

      if (!userExist) {
        return Left(ErrorModel(message: 'Email and/or password invalid!'));
      }

      final jwt = JWT({'user': data['email']});

      final token = jwt.sign(
        SecretKey(_secretKey),
        expiresIn: const Duration(hours: 1),
      );

      // Emulates API call
      await Future.delayed(const Duration(seconds: 1));

      return Right({'token': token});
    } catch (error) {
      return Left(ErrorModel.fromError(error));
    }
  }

  AsyncResponse<int> validate(String token) async {
    try {
      final jwt = JWT.verify(token, SecretKey(_secretKey));

      final exp = jwt.payload['exp'] as int;

      // Emulates API call
      await Future.delayed(const Duration(seconds: 1));

      return Right(exp);
    } catch (error) {
      return Left(ErrorModel.fromError(error));
    }
  }

  AsyncResponse<void> logout() async {
    try {
      // Emulates API call
      await Future.delayed(const Duration(seconds: 1));

      return const Right(null);
    } catch (error) {
      return Left(ErrorModel.fromError(error));
    }
  }
}
