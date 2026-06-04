import 'package:dartz/dartz.dart';
import 'package:weather_forecast/core/api/error_model.dart';

typedef Json = Map<String, dynamic>;
typedef JsonList = List<Map<String, dynamic>>;

typedef Response<S> = Either<ErrorModel, S>;
typedef AsyncResponse<S> = Future<Either<ErrorModel, S>>;
