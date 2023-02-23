import 'package:dio/dio.dart' show Response;

import '_network_error.dart';

class ResponseNetworkError extends NetworkError {
  final Response response;

  const ResponseNetworkError({
    required super.stackTrace,
    required this.response,
  });
}
