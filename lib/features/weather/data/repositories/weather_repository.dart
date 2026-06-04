import 'package:dartz/dartz.dart';
import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_forecast/features/weather/domain/abstractions/iweather_repository.dart';
import 'package:weather_forecast/features/weather/domain/models/weather_model.dart';

class WeatherRepository extends IWeatherRepository {
  WeatherRepository({required this.remoteDatasource});

  final WeatherRemoteDatasource remoteDatasource;

  @override
  AsyncResponse<WeatherModel> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final query = {
      'latitude': latitude,
      'longitude': longitude,
      'hourly': 'temperature_2m',
      'timezone': 'auto',
      'daily': 'temperature_2m_max,temperature_2m_min',
    };

    final response = await remoteDatasource.getCurrentWeather(query);

    return response.fold(
      Left.new,
      (success) => Right(WeatherModel.fromJson(success)),
    );
  }
}
