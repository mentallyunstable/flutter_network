import '../data.dart';

/// The base class returned by the network service [RectClient].
///
/// [T] is a generic type for decoding [Response] data.
///
/// [SuccessfulResult] - successful response with decoded data of [T] type.
///
/// [ErrorResult] — error response with specified [Exception].
abstract class Result<T, E extends ErrorData> {
  const factory Result.success({required final T? data}) = SuccessfulResult;

  const factory Result.error({
    required final NetworkError error,
    final E? data,
  }) = ErrorResult;
}
