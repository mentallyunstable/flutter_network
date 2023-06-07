import 'package:dio/dio.dart' show Response;

import 'network_error.dart';

/// Describes [NetworkError] when request ended with the error.
/// Usually returned when [Response.statusCode] is >= 400 < 500.
class ResponseNetworkError extends NetworkError {
  /// Refer to [Response] from dio package.
  final Response response;

  const ResponseNetworkError({
    required super.stackTrace,
    required this.response,
  });
}
