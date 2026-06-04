import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/features/weather/domain/models/geolocation_model.dart';
import 'package:weather_forecast/features/weather/domain/models/weather_model.dart';
import 'package:weather_forecast/features/weather/domain/usecases/weather_usecase.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherUsecase})
    : super(const WeatherIdleState());

  final WeatherUsecase weatherUsecase;

  Future<void> getCurrentWeather(GeolocationModel location) async {
    emit(const WeatherLoadingState());

    final response = await weatherUsecase.getCurrentWeather(location);

    return response.fold(
      (error) => emit(WeatherFailState(error: error)),
      (weather) => emit(WeatherSuccessState(weather: weather)),
    );
  }
}
