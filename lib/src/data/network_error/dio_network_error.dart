import 'package:dio/dio.dart' show DioError;

import '_network_error.dart';

class DioNetworkError extends NetworkError {
  final DioError dioError;

  const DioNetworkError({
    required super.stackTrace,
    required this.dioError,
  });
}
