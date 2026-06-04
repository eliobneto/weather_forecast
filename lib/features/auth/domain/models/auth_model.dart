import 'package:weather_forecast/core/definitions/types.dart';

class AuthModel {
  factory AuthModel.fromJson(Json json) => AuthModel(
    email: json['email'],
    password: json['password'],
    showCredentials: json['showCredentials'],
  );

  AuthModel({
    required this.email,
    required this.password,
    required this.showCredentials,
  });

  final String email;
  final String password;
  final bool showCredentials;

  Json toJson() => {
    'email': email,
    'password': password,
    'showCredentials': showCredentials,
  };
}
