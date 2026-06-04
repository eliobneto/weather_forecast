part of 'weather_cubit.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherIdleState extends WeatherState {
  const WeatherIdleState();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class WeatherSuccessState extends WeatherState {
  WeatherSuccessState({required this.weather});

  final WeatherModel weather;
}

class WeatherFailState extends WeatherState {
  WeatherFailState({required this.error});

  final ErrorModel error;
}
