class NetworkLoggerOptions {
  /// Any logs will be printed only while [kDebugMode] is [true]
  final bool printOnlyDebug;

  /// Print request logs before the request
  final bool printRequest;

  /// Print response logs if request was successful
  final bool printResponse;

  /// Print error logs if request ended with an error
  final bool printError;

  /// Print response headers if response was successful
  final bool printResponseHeaders;

  /// Print response body if response was successful
  final bool printResponseBody;

  const NetworkLoggerOptions({
    this.printOnlyDebug = true,
    this.printRequest = true,
    this.printResponse = true,
    this.printError = true,
    this.printResponseHeaders = false,
    this.printResponseBody = true,
  });

  NetworkLoggerOptions copyWith({
    final bool? printOnlyDebug,
    final bool? printRequest,
    final bool? printResponse,
    final bool? printError,
    final bool? printResponseHeaders,
    final bool? printResponseBody,
  }) {
    return NetworkLoggerOptions(
      printOnlyDebug: printOnlyDebug ?? this.printOnlyDebug,
      printRequest: printRequest ?? this.printRequest,
      printResponse: printResponse ?? this.printResponse,
      printError: printError ?? this.printError,
      printResponseHeaders: printResponseHeaders ?? this.printResponseHeaders,
      printResponseBody: printResponseBody ?? this.printResponseBody,
    );
  }
}
