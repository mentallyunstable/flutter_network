import 'package:flutter_network/flutter_network.dart';
import '../logger/logger.dart';

import 'package:dio/dio.dart';

/// Represents configurable options for [NetworkService].
class NetworkOptions<T extends ErrorData> {
  /// [Connection] instance that performs an internet connection checks.
  /// It's not necessary to provide [Connection] object,
  /// it will be created automatically with default options.
  ///
  /// Refer to connectivity_plus package for detailed info.
  final Connection connection;

  /// [NetworkLoggerOptions] provides conditions for logging via [NetworkLogger].
  /// It's not necessary to provide [NetworkLoggerOptions] object,
  /// it will be created automatically with default options.
  final NetworkLoggerOptions loggerOptions;

  /// [NetworkService] will create [Dio] instance itself for doing requests.
  ///
  /// [Dio] object can be provided in the constructor instead if needed.
  final Dio? dio;

  /// [NetworkService] will create [BaseOptions] itself for [dio] instance
  /// with default parameters.
  ///
  /// [BaseOptions] can be provided in the constructor instead if needed.
  ///
  /// Also [dio] instance can be provided in the constructor with
  /// specified [BaseOptions] instance if provided.
  final BaseOptions? baseOptions;

  /// Base url to build requests, for example:
  ///
  /// When doing request, provide [baseUrl] as "https://example.com/api/" and path
  /// as "user/1" so full url will look like "https://example.com/api/user/1".
  final String? baseUrl;

  /// Decoding method for [NetworkService], returning error response data.
  /// If null, data will not be decoded and [ErrorResult.data] will also be null.
  final T Function(Map<String, dynamic> json)? errorDataFromJson;

  /// Should [NetworkService] firstly check for the internet connection and
  /// return [NetworkError.connection] due to the connection error.
  final bool checkConnection;

  /// Should [NetworkService] use [NetworkLogger] as [Interceptor].
  final bool useLogger;

  /// Refer to followRedirects in dio package.
  final bool? followRedirects;

  /// Refer to validateStatus property in dio package.
  final bool Function(int? status)? validateStatus;

  /// Interceptors to use (if provided) when creating [dio] instance.
  ///
  /// Refer to dio [Interceptor] for detailed info.
  final List<Interceptor>? interceptors;

  const NetworkOptions({
    this.connection = const Connection(),
    this.loggerOptions = const NetworkLoggerOptions(),
    this.dio,
    this.baseOptions,
    this.baseUrl,
    this.errorDataFromJson,
    this.checkConnection = true,
    this.useLogger = true,
    this.validateStatus,
    this.followRedirects,
    this.interceptors,
  });

  /// Creates a copy of this object but with the given fields replaced with the new values.
  NetworkOptions copyWith({
    final Connection? connection,
    final NetworkLoggerOptions? loggerOptions,
    final Dio? dio,
    final BaseOptions? baseOptions,
    final String? baseUrl,
    final T Function(Map<String, dynamic> json)? errorDataFromJson,
    final bool? checkConnection,
    final bool? useLogger,
    final bool Function(int? status)? validateStatus,
    final bool? followRedirects,
    final List<Interceptor>? interceptors,
  }) {
    return NetworkOptions(
      connection: connection ?? this.connection,
      loggerOptions: loggerOptions ?? this.loggerOptions,
      dio: dio ?? this.dio,
      baseOptions: baseOptions ?? this.baseOptions,
      baseUrl: baseUrl ?? this.baseUrl,
      errorDataFromJson: errorDataFromJson ?? this.errorDataFromJson,
      checkConnection: checkConnection ?? this.checkConnection,
      useLogger: useLogger ?? this.useLogger,
      validateStatus: validateStatus ?? this.validateStatus,
      followRedirects: followRedirects ?? this.followRedirects,
      interceptors: interceptors ?? this.interceptors,
    );
  }
}
