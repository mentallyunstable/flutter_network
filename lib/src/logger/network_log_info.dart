import 'package:dio/dio.dart';

import '../data/data.dart';
import '../options/logger_options.dart';

/// Describes info for [NetworkLogger] to print. This object builds while
/// doing requests and handling their responses.
class NetworkLogInfo {
  final NetworkLoggerOptions loggerOptions;
  final String baseUrl;
  final String path;
  final String method;
  final Object? requestData;
  final ResponseType? responseType;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final CancelToken? cancelToken;
  final ProgressCallback? onReceiveProgress;
  final Response? response;
  final NetworkError? error;

  const NetworkLogInfo({
    required this.loggerOptions,
    required this.baseUrl,
    required this.path,
    required this.method,
    required this.responseType,
    this.requestData,
    this.headers,
    this.queryParameters,
    this.options,
    this.cancelToken,
    this.onReceiveProgress,
    this.response,
    this.error,
  });

  String get url => baseUrl + path;

  NetworkLogInfo copyWith({
    final NetworkLoggerOptions? loggerOptions,
    final String? path,
    final String? baseUrl,
    final String? method,
    final Object? requestData,
    final ResponseType? responseType,
    final Map<String, dynamic>? headers,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
    final Response? response,
    final NetworkError? error,
  }) {
    return NetworkLogInfo(
      loggerOptions: loggerOptions ?? this.loggerOptions,
      baseUrl: baseUrl ?? this.baseUrl,
      path: path ?? this.path,
      method: method ?? this.method,
      requestData: requestData ?? this.requestData,
      responseType: responseType ?? this.responseType,
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
      options: options ?? this.options,
      cancelToken: cancelToken ?? this.cancelToken,
      onReceiveProgress: onReceiveProgress ?? this.onReceiveProgress,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}
