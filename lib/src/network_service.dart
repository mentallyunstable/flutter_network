import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_network/flutter_network.dart';

import 'logger/_logger.dart';

/// HTTP service for doing requests and decoding response data.
/// Supports multiple types of error and highly customizable for any purposes.
///
/// Built upon dio package.
/// For more complex info on how HTTP client works, refer to dio package documentary.
class NetworkService {
  final NetworkOptions options;

  final Dio _dio;

  NetworkService(this.options)
      : _dio = options.dio ??
            Dio(
              options.baseOptions ??
                  BaseOptions(
                    baseUrl: options.baseUrl!,
                    followRedirects: options.followRedirects ?? false,
                    validateStatus: options.validateStatus ??
                        (status) => status! >= 200 && status < 300,
                  ),
            ) {
    if (options.useLogger) {
      _dio.interceptors.add(NetworkLoggerInterceptor(options.loggerOptions));
    }

    if (options.interceptors != null) {
      _dio.interceptors.addAll(options.interceptors!);
    }
  }

  /// Method to make http GET request.
  ///
  /// [path] - request endpoint.
  ///
  /// [fromJson] - method that will handle model creation when decoding data,
  /// it can be factory constructor or static method.
  ///
  /// Returns [SuccessfulResult] if request was successful and response data
  /// has been decoded to the provided generic [T] model.
  ///
  /// Returns [ErrorResult] with exception if request wasn't successful due
  /// to any error.
  ///
  /// If device has no internet connection, returns
  /// [ErrorResult] with [ConnectionNetworkError].
  ///
  /// If response data can't be decoded, throws [TypeError] and returns
  /// [ErrorResult] with [TypeNetworkError].
  ///
  /// If response status code is >=400 < 500, returns [ResponseNetworkError]
  /// with decoded data, if [NetworkOptions.errorDataFromJson] was provided.
  ///
  /// If response status code is >= 300 < 400 and >= 500, returns [DioNetworkError].
  Future<Result<T, E>> get<T, E extends ErrorData>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    final NetworkOptions? networkOptions,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions:
          networkOptions?.loggerOptions ?? this.options.loggerOptions,
      baseUrl: networkOptions?.baseUrl ??
          this.options.baseUrl ??
          _dio.options.baseUrl,
      path: path,
      method: 'GET',
      headers: options?.headers,
      queryParameters: queryParameters,
      responseType: options?.responseType,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return _handleRequest(
      request: _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      fromJson: fromJson,
      logInfo: logInfo,
      options: networkOptions,
    );
  }

  /// Method to make http POST request.
  ///
  /// [path] - request endpoint.
  ///
  /// [fromJson] - method that will handle model creation when decoding data,
  /// it can be factory constructor or static method.
  ///
  /// If request [data] is not [Map] object, it will be encoded with [jsonEncode].
  ///
  /// Returns [SuccessfulResult] if request was successful and response data
  /// has been decoded to the provided generic [T] model.
  ///
  /// Returns [ErrorResult] with exception if request wasn't successful due
  /// to any error.
  ///
  /// If device has no internet connection, returns
  /// [ErrorResult] with [ConnectionNetworkError].
  ///
  /// If response data can't be decoded, throws [TypeError] and returns
  /// [ErrorResult] with [TypeNetworkError].
  ///
  /// If response status code is >=400 < 500, returns [ResponseNetworkError]
  /// with decoded data, if [NetworkOptions.errorDataFromJson] was provided.
  ///
  /// If response status code is >= 300 < 400 and >= 500, returns [DioNetworkError].
  Future<Result<T, E>> post<T, E extends ErrorData>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    final Object? data = const {},
    final NetworkOptions? networkOptions,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions:
          networkOptions?.loggerOptions ?? this.options.loggerOptions,
      baseUrl: networkOptions?.baseUrl ??
          this.options.baseUrl ??
          _dio.options.baseUrl,
      path: path,
      method: 'POST',
      headers: options?.headers,
      queryParameters: queryParameters,
      responseType: options?.responseType,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return _handleRequest(
      request: _dio.post(
        path,
        data: data is Map ? data : jsonEncode(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      fromJson: fromJson,
      logInfo: logInfo,
      options: networkOptions,
    );
  }

  /// Method to make http PUT request.
  ///
  /// [path] - request endpoint.
  ///
  /// [fromJson] - method that will handle model creation when decoding data,
  /// it can be factory constructor or static method.
  ///
  /// If request [data] is not [Map] object, it will be encoded with [jsonEncode].
  ///
  /// Returns [SuccessfulResult] if request was successful and response data
  /// has been decoded to the provided generic [T] model.
  ///
  /// Returns [ErrorResult] with exception if request wasn't successful due
  /// to any error.
  ///
  /// If device has no internet connection, returns
  /// [ErrorResult] with [ConnectionNetworkError].
  ///
  /// If response data can't be decoded, throws [TypeError] and returns
  /// [ErrorResult] with [TypeNetworkError].
  ///
  /// If response status code is >=400 < 500, returns [ResponseNetworkError]
  /// with decoded data, if [NetworkOptions.errorDataFromJson] was provided.
  ///
  /// If response status code is >= 300 < 400 and >= 500, returns [DioNetworkError].
  Future<Result<T, E>> put<T, E extends ErrorData>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    required final Object data,
    final NetworkOptions? networkOptions,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions:
          networkOptions?.loggerOptions ?? this.options.loggerOptions,
      baseUrl: networkOptions?.baseUrl ??
          this.options.baseUrl ??
          _dio.options.baseUrl,
      path: path,
      method: 'PUT',
      headers: options?.headers,
      queryParameters: queryParameters,
      responseType: options?.responseType,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return _handleRequest(
      request: _dio.put(
        path,
        data: data is Map ? data : jsonEncode(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      fromJson: fromJson,
      logInfo: logInfo,
      options: networkOptions,
    );
  }

  /// Method to make http PATCH request.
  ///
  /// [path] - request endpoint.
  ///
  /// [fromJson] - method that will handle model creation when decoding data,
  /// it can be factory constructor or static method.
  ///
  /// If request [data] is not [Map] object, it will be encoded with [jsonEncode].
  ///
  /// Returns [SuccessfulResult] if request was successful and response data
  /// has been decoded to the provided generic [T] model.
  ///
  /// Returns [ErrorResult] with exception if request wasn't successful due
  /// to any error.
  ///
  /// If device has no internet connection, returns
  /// [ErrorResult] with [ConnectionNetworkError].
  ///
  /// If response data can't be decoded, throws [TypeError] and returns
  /// [ErrorResult] with [TypeNetworkError].
  ///
  /// If response status code is >=400 < 500, returns [ResponseNetworkError]
  /// with decoded data, if [NetworkOptions.errorDataFromJson] was provided.
  ///
  /// If response status code is >= 300 < 400 and >= 500, returns [DioNetworkError].
  Future<Result<T, E>> patch<T, E extends ErrorData>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    required final Object data,
    final NetworkOptions? networkOptions,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions:
          networkOptions?.loggerOptions ?? this.options.loggerOptions,
      baseUrl: networkOptions?.baseUrl ??
          this.options.baseUrl ??
          _dio.options.baseUrl,
      path: path,
      method: 'PATCH',
      headers: options?.headers,
      queryParameters: queryParameters,
      responseType: options?.responseType,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return _handleRequest(
      request: _dio.patch(
        path,
        data: data is Map ? data : jsonEncode(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      fromJson: fromJson,
      logInfo: logInfo,
      options: networkOptions,
    );
  }

  /// Method to make http DELETE request.
  ///
  /// [path] - request endpoint.
  ///
  /// [fromJson] - method that will handle model creation when decoding data,
  /// it can be factory constructor or static method.
  ///
  /// If request [data] is not [Map] object, it will be encoded with [jsonEncode].
  ///
  /// Returns [SuccessfulResult] if request was successful and response data
  /// has been decoded to the provided generic [T] model.
  ///
  /// Returns [ErrorResult] with exception if request wasn't successful due
  /// to any error.
  ///
  /// If device has no internet connection, returns
  /// [ErrorResult] with [ConnectionNetworkError].
  ///
  /// If response data can't be decoded, throws [TypeError] and returns
  /// [ErrorResult] with [TypeNetworkError].
  ///
  /// If response status code is >=400 < 500, returns [ResponseNetworkError]
  /// with decoded data, if [NetworkOptions.errorDataFromJson] was provided.
  ///
  /// If response status code is >= 300 < 400 and >= 500, returns [DioNetworkError].
  Future<Result<T, E>> delete<T, E extends ErrorData>(
    final String path, {
    final T Function(Map<String, dynamic> json)? fromJson,
    final Object? data = const {},
    final NetworkOptions? networkOptions,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions:
          networkOptions?.loggerOptions ?? this.options.loggerOptions,
      baseUrl: networkOptions?.baseUrl ??
          this.options.baseUrl ??
          _dio.options.baseUrl,
      path: path,
      method: 'DELETE',
      headers: options?.headers,
      queryParameters: queryParameters,
      responseType: options?.responseType,
      options: options,
      cancelToken: cancelToken,
    );

    return _handleRequest(
      request: _dio.delete(
        path,
        data: data is Map ? data : jsonEncode(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      fromJson: fromJson,
      logInfo: logInfo,
      options: networkOptions,
    );
  }

  /// Decoding [Response.data] to the provided [T] generic type.
  T? _decode<T>(
    final Response response,
    final T Function(Map<String, dynamic> json)? fromJson,
  ) {
    if (fromJson == null) {
      return null;
    }

    if (response.data is Map) {
      return _decodeMap(response, fromJson);
    }

    if (response.data is List) {
      return _decodeList(response, fromJson);
    }

    throw TypeError();
  }

  /// Decoding response data if it has type of [Map].
  T _decodeMap<T>(
    final Response response,
    final T Function(Map<String, dynamic> json) fromJson,
  ) =>
      fromJson(response.data);

  /// Decoding response data if it has type of [List].
  T _decodeList<T>(
    final Response response,
    final T Function(Map<String, dynamic> json) fromJson,
  ) {
    final list = response.data as List;

    return List.from(list.map((item) => fromJson(item)).toList()) as T;
  }

  /// Doing request, handling response and returns [Result].
  Future<Result<T, E>> _handleRequest<T, E extends ErrorData>({
    required final Future<Response> request,
    required final T Function(Map<String, dynamic> json)? fromJson,
    required NetworkLogInfo logInfo,
    NetworkOptions? options,
  }) async {
    final networkOptions = options ?? this.options;
    try {
      if (networkOptions.checkConnection &&
          await networkOptions.connection.isNotConnected) {
        const error = NetworkError.connection();

        NetworkLogger.logError(logInfo.copyWith(error: error));

        return const Result.error(error: error);
      }

      final response = await request;
      logInfo = logInfo.copyWith(response: response);

      return Result.success(
        response: response,
        data: _decode(response, fromJson),
      );
    } on TypeError catch (typeError, stackTrace) {
      final error = NetworkError.type(
        stackTrace: stackTrace,
        typeError: typeError,
      );

      NetworkLogger.logError(logInfo.copyWith(error: error));

      return Result.error(error: error);
    } on DioException catch (dioException, stackTrace) {
      final error = dioException.response?.data != null
          ? NetworkError.response(
              stackTrace: stackTrace,
              response: dioException.response!,
            )
          : NetworkError.dio(
              stackTrace: stackTrace,
              dioException: dioException,
            );

      NetworkLogger.logError(logInfo.copyWith(
        error: error,
        response: dioException.response,
      ));

      return Result.error(
        error: error,
        data: dioException.response?.data != null &&
                networkOptions.errorDataFromJson != null
            ? networkOptions.errorDataFromJson!(dioException.response!.data)
                as E
            : null,
      );
    }
  }
}
