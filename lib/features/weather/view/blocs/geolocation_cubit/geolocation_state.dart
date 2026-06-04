part of 'geolocation_cubit.dart';

abstract class GeolocationState {
  const GeolocationState();
}

class GeolocationIdleState extends GeolocationState {
  const GeolocationIdleState();
}

class GeolocationLoadingState extends GeolocationState {
  const GeolocationLoadingState();
}

class GeolocationSuccessState extends GeolocationState {
  GeolocationSuccessState({required this.location});

  final GeolocationModel location;
}

class GeolocationFailState extends GeolocationState {
  GeolocationFailState({required this.error});

  final ErrorModel error;
}
