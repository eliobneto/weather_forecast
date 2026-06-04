import 'package:weather_forecast/core/definitions/types.dart';

class UserModel {
  factory UserModel.fromJson(Json json) => UserModel(token: json['token']);

  UserModel({required this.token});

  final String token;

  Json toJson() => {'token': token};
}
