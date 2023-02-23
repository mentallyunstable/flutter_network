import 'successful_result.dart';
import 'error_result.dart';

import 'package:flutter_network/src/data/network_error/_network_error.dart';

/// The base class returned by the network service [RectClient].
///
/// [T] is a generic type for decoding [Response] data.
///
/// [SuccessfulResult] - successful response with decoded data of [T] type.
///
/// [ErrorResult] — error response with specified [Exception].
abstract class Result<T> {
  const factory Result.success({required final T? data}) = SuccessfulResult;

  const factory Result.error({required final NetworkError error}) = ErrorResult;
}
