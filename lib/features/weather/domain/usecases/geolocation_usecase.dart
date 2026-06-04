import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/core/api/error_model.dart';
import 'package:weather_forecast/core/definitions/types.dart';
import 'package:weather_forecast/features/weather/domain/models/geolocation_model.dart';

class GeolocationUsecase {
  AsyncResponse<GeolocationModel> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check permission
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Location permission permanently denied. Open app settings.',
        );
      }

      final position = await Geolocator.getCurrentPosition();

      return Right(
        GeolocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (error) {
      return Left(ErrorModel.fromError(error));
    }
  }
}
