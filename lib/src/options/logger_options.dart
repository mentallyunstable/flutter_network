import 'package:flutter_network/src/logger/_logger.dart' show NetworkLogger;

/// Represents configurable options for [NetworkLogger].
class NetworkLoggerOptions {
  /// Any logs will be printed only while [kDebugMode] is true.
  final bool printOnlyInDebug;

  /// Print request logs before the request.
  final bool printRequest;

  /// Print [Response] logs if request was successful.
  final bool printResponse;

  /// Print error logs if request ends with an error.
  final bool printError;

  /// Print [Response] headers if request was successful.
  final bool printResponseHeaders;

  /// Print [Response] body if request was successful.
  final bool printResponseBody;

  const NetworkLoggerOptions({
    this.printOnlyInDebug = true,
    this.printRequest = true,
    this.printResponse = true,
    this.printError = true,
    this.printResponseHeaders = false,
    this.printResponseBody = true,
  });

  /// Creates a copy of object but with the given fields replaced with the new values.
  NetworkLoggerOptions copyWith({
    final bool? printOnlyInDebug,
    final bool? printRequest,
    final bool? printResponse,
    final bool? printError,
    final bool? printResponseHeaders,
    final bool? printResponseBody,
  }) {
    return NetworkLoggerOptions(
      printOnlyInDebug: printOnlyInDebug ?? this.printOnlyInDebug,
      printRequest: printRequest ?? this.printRequest,
      printResponse: printResponse ?? this.printResponse,
      printError: printError ?? this.printError,
      printResponseHeaders: printResponseHeaders ?? this.printResponseHeaders,
      printResponseBody: printResponseBody ?? this.printResponseBody,
    );
  }
}
