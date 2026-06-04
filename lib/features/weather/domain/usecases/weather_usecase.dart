import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/weather/domain/abstractions/iweather_repository.dart';
import 'package:weather_forecast/features/weather/domain/models/geolocation_model.dart';
import 'package:weather_forecast/features/weather/domain/models/weather_model.dart';

class WeatherUsecase {
  WeatherUsecase({required this.weatherRepository});

  final IWeatherRepository weatherRepository;

  AsyncResponse<WeatherModel> getCurrentWeather(GeolocationModel location) =>
      weatherRepository.getCurrentWeather(
        latitude: location.latitude,
        longitude: location.longitude,
      );
}
