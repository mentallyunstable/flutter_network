import 'package:dio/dio.dart' show Response;

import '../data.dart';

/// Describes the error response done by [NetworkService].
/// For successful response refer to [SuccessfulResult].
class ErrorResult<T, E extends ErrorData> implements Result<T, E> {
  ///
  final NetworkError error;
  /// Decoded error [Response.data].
  final E? data;

  const ErrorResult({required this.error, this.data});
}
