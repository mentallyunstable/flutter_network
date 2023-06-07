import 'package:dio/dio.dart' show Response;

import '../data.dart';

/// The base abstract class returned by the [NetworkService].
/// For detailed info about subclasses, refer to [SuccessfulResult] and [ErrorResult].
///
/// [T] is a generic type for decoding [Response] data.
///
/// [E] is a generic type for decoding error [Response] data and must be
/// subclass of the [ErrorData].
abstract class Result<T, E extends ErrorData> {
  const factory Result.success({
    required final Response response,
    required final T? data,
  }) = SuccessfulResult;

  const factory Result.error({
    required final NetworkError error,
    final E? data,
  }) = ErrorResult;
}
