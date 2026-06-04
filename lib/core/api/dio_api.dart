import 'package:dio/dio.dart';
import 'package:weather_forecast/features/auth/domain/interceptors/auth_interceptor.dart';

abstract class IDioApi {
  Dio get dio;
}

class DioApi extends IDioApi {
  DioApi() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }

  void addInterceptors({required IAuthInterceptor authInterceptor}) {
    authInterceptor.setDio(dio);

    dio.interceptors.addAll([authInterceptor, LogInterceptor()]);
  }

  @override
  late final Dio dio;
}
