import 'package:dio/dio.dart' show Response, DioException;

import 'connection_network_error.dart';
import 'dio_network_error.dart';
import 'response_network_error.dart';
import 'type_network_error.dart';

/// Base class for all types of errors created by [NetworkService] requests.
abstract class NetworkError {
  final StackTrace? stackTrace;

  const NetworkError({this.stackTrace});

  const factory NetworkError.connection() = ConnectionNetworkError;

  const factory NetworkError.type({
    required final StackTrace stackTrace,
    required final TypeError typeError,
  }) = TypeNetworkError;

  const factory NetworkError.response({
    required final StackTrace stackTrace,
    required final Response response,
  }) = ResponseNetworkError;

  const factory NetworkError.dio({
    required final StackTrace stackTrace,
    required final DioException dioException,
  }) = DioNetworkError;
}
