import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/features/weather/domain/models/geolocation_model.dart';
import 'package:weather_forecast/features/weather/domain/usecases/geolocation_usecase.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit({required this.geolocationUsecase})
    : super(const GeolocationIdleState());

  final GeolocationUsecase geolocationUsecase;

  Future<void> getCurrentPosition() async {
    emit(const GeolocationLoadingState());

    final response = await geolocationUsecase.getCurrentLocation();

    return response.fold(
      (error) => emit(GeolocationFailState(error: error)),
      (location) => emit(GeolocationSuccessState(location: location)),
    );
  }
}
