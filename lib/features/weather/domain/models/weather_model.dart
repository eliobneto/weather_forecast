import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/weather/domain/models/hourly_temperature_model.dart';
import 'package:weather_forecast/features/weather/domain/models/max_min_temperature_model.dart';

class WeatherModel {
  factory WeatherModel.fromJson(Json json) {
    final hourlyTimeList = List<String>.from(json['hourly']['time']);
    final hourlyTempList = List<double>.from(json['hourly']['temperature_2m']);

    final currentTime = DateTime.now();

    // Find closest hourly index
    final closestIndex = hourlyTimeList.indexed
        .firstWhere(
          (entry) =>
              currentTime.difference(DateTime.parse(entry.$2)).isNegative,
        )
        .$1;

    final currentWeather = hourlyTempList[closestIndex].round();

    final hourlyTemperatureList = <HourlyTemperatureModel>[];

    // Next 24 hours
    for (var i = closestIndex; hourlyTemperatureList.length < 24; i++) {
      hourlyTemperatureList.add(
        HourlyTemperatureModel(
          time: DateTime.parse(hourlyTimeList[i]),
          temperature: hourlyTempList[i].round(),
        ),
      );
    }

    // Daily forecasts
    final dailyTimeList = List<String>.from(json['daily']['time']);
    final maxTempList = List<double>.from(json['daily']['temperature_2m_max']);
    final minTempList = List<double>.from(json['daily']['temperature_2m_min']);

    final maxMinTemperatureList = List.generate(
      dailyTimeList.length,
      (index) => MaxMinTemperatureModel(
        time: DateTime.parse(dailyTimeList[index]),
        maxTemperature: maxTempList[index].round(),
        minTemperature: minTempList[index].round(),
      ),
    );

    final currentMaxMinTemperature = maxMinTemperatureList.removeAt(0);

    return WeatherModel(
      currentWeather: currentWeather,
      currentMaxMinTemperature: currentMaxMinTemperature,
      hourlyTemperatureList: hourlyTemperatureList,
      maxMinTemperatureList: maxMinTemperatureList,
    );
  }

  WeatherModel({
    required this.currentWeather,
    required this.currentMaxMinTemperature,
    required this.hourlyTemperatureList,
    required this.maxMinTemperatureList,
  });

  final int currentWeather;
  final MaxMinTemperatureModel currentMaxMinTemperature;
  final List<HourlyTemperatureModel> hourlyTemperatureList;
  final List<MaxMinTemperatureModel> maxMinTemperatureList;
}
