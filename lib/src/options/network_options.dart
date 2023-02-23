import 'package:flutter_network/flutter_network.dart';

export 'package:dio/dio.dart' show Dio, BaseOptions, Interceptor;

class NetworkOptions {
  /// [Connection] instance that performs an internet connection checks
  /// It's not necessary to provide [Connection] object,
  /// it will be created automatically with default options
  final Connection connection;

  /// [NetworkLoggerOptions] provides conditions for logging via [NetworkLogger]
  /// It's not necessary to provide [NetworkLoggerOptions] object,
  /// it will be created automatically with default options
  final NetworkLoggerOptions loggerOptions;

  /// [NetworkService] will create [Dio] instance itself for doing requests
  ///
  /// [Dio] can be provided in the constructor instead if needed
  final Dio? dio;

  /// [NetworkService] will create [BaseOptions] itself for [dio] instance
  /// with default parameters
  ///
  /// [BaseOptions] can be provided in the constructor instead if needed
  ///
  /// Also [dio] instance can be provided in the constructor with
  /// specified [BaseOptions] instance if provided
  final BaseOptions? baseOptions;

  /// Base url to build requests, for example:
  ///
  /// Provide [baseUrl] as ['https://example.com/api/'] and [path] when doing request
  /// as ['user/1'] will be as ['https://example.com/api/user/1']
  final String? baseUrl;

  /// Should [NetworkService] firstly check for the internet connection and
  /// return [NetworkError.connection] due to the connection error
  final bool checkConnection;

  /// Should [NetworkService] use [NetworkLogger] as [dio.Interceptor]
  final bool useLogger;

  /// Refer to followRedirects in [Dio] package
  final bool? followRedirects;

  /// Refer to validateStatus property in [Dio] package
  final bool Function(int? status)? validateStatus;

  /// Interceptors to use (if provided) when creating [dio] instance
  ///
  /// Refer to dio [Interceptor] for detailed info
  final List<Interceptor>? interceptors;

  const NetworkOptions({
    this.connection = const Connection(),
    this.loggerOptions = const NetworkLoggerOptions(),
    this.dio,
    this.baseOptions,
    this.baseUrl,
    this.checkConnection = true,
    this.useLogger = true,
    this.validateStatus,
    this.followRedirects,
    this.interceptors,
  });

  NetworkOptions copyWith({
    final Connection? connection,
    final NetworkLoggerOptions? loggerOptions,
    final Dio? dio,
    final BaseOptions? baseOptions,
    final String? baseUrl,
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
      checkConnection: checkConnection ?? this.checkConnection,
      useLogger: useLogger ?? this.useLogger,
      validateStatus: validateStatus ?? this.validateStatus,
      followRedirects: followRedirects ?? this.followRedirects,
      interceptors: interceptors ?? this.interceptors,
    );
  }
}
