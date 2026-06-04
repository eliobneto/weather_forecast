import 'package:dartz/dartz.dart';
import 'package:weather_forecast/core/api/dio_api.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/core/definitions/types.dart';

class WeatherRemoteDatasource {
  WeatherRemoteDatasource({required this.api});

  final IDioApi api;

  AsyncResponse<Json> getCurrentWeather(Json query) async {
    const url = 'https://api.open-meteo.com/v1/forecast';

    try {
      final response = await api.dio.get(url, queryParameters: query);

      return Right(response.data);
    } catch (error) {
      return Left(ErrorModel.fromError(error));
    }
  }
}
