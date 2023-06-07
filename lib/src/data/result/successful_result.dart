import 'package:dio/dio.dart';

import 'package:flutter_network/flutter_network.dart';

/// Describes a successful response done by [NetworkService].
/// For error response refer to [ErrorResult].
///
/// [Response.data] will be decoded to object with specified by [T] type.
class SuccessfulResult<T, E extends ErrorData> implements Result<T, E> {
  /// Response describes the http Response info. Refer to [Response] from [dio] package.
  final Response response;
  /// Decoded [Response.data] object with specified [T] type.
  /// Can be [Null] if fromJson was null when calling [NetworkService] request.
  final T? data;

  const SuccessfulResult({required this.response, required this.data});
}
