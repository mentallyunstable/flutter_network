import 'package:dio/dio.dart' show Response, DioException;

import 'network_error.dart';

/// Describes [NetworkError] when request ended with the error.
/// Usually returned when [Response.statusCode] is >= 300 < 400 or >= 500.
class DioNetworkError extends NetworkError {
  /// Refer to [DioException] from dio package.
  final DioException dioException;

  const DioNetworkError({
    required super.stackTrace,
    required this.dioException,
  });
}
