import 'package:dio/dio.dart';

class ErrorModel {
  factory ErrorModel.fromError(Object error) {
    if (error is DioException) {
      if (error.connectionFailed) {
        return ErrorModel(
          message:
              'Connection error, please check if you are connected to the internet.',
          statusCode: 502,
        );
      }

      if (error.response != null) {
        return ErrorModel(
          message: error.response!.data,
          statusCode: error.response!.statusCode!,
        );
      }
    }

    return ErrorModel(message: error.toString(), statusCode: 502);
  }

  ErrorModel({
    this.message =
        'An unknown error occurred in the system, contact the system administrator if the error persists.',
    this.statusCode = 502,
  });

  final String message;
  final int statusCode;
}

extension on DioException {
  bool get connectionFailed =>
      type == DioExceptionType.connectionError ||
      type == DioExceptionType.connectionTimeout ||
      type == DioExceptionType.receiveTimeout ||
      type == DioExceptionType.sendTimeout;
}
