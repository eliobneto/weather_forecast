import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/features/auth/domain/abstractions/iauth_repository.dart';
import 'package:weather_forecast/features/user/domain/abstractions/iuser_repository.dart';
import 'package:weather_forecast/features/user/domain/models/user_model.dart';

abstract class IAuthInterceptor extends Interceptor {
  void setDio(Dio dio);
}

class AuthInterceptor extends IAuthInterceptor {
  AuthInterceptor({required this.authRepository, required this.userRepository});

  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  late Dio dio;

  @override
  void setDio(Dio dio) {
    this.dio = dio;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final user = await userRepository.readLocalUser();

      if (user is UserModel) {
        authRepository.validate(user.token);
      }
    } catch (err) {
      debugPrint('Error performing authentication: ${err.toString()}');
    } finally {
      handler.next(options);
    }
  }
}
