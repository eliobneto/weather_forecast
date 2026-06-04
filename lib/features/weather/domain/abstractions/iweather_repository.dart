import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/weather/domain/models/weather_model.dart';

abstract class IWeatherRepository {
  AsyncResponse<WeatherModel> getCurrentWeather({
    required double latitude,
    required double longitude,
  });
}
