import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_network/flutter_network.dart';

import 'logger/_logger.dart';

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
                        (status) => status! >= 200 && status < 500,
                  ),
            ) {
    if (options.useLogger) {
      _dio.interceptors.add(NetworkLoggerInterceptor(options.loggerOptions));
    }

    if (options.interceptors != null) {
      _dio.interceptors.addAll(options.interceptors!);
    }
  }

  /// Method to make http GET request which is a alias of [dio.fetch(RequestOptions)].
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
  /// [ErrorResult] with [NoConnectionError].
  Future<Result<T>> get<T>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions: this.options.loggerOptions,
      baseUrl: this.options.baseUrl ?? _dio.options.baseUrl,
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
    );
  }

  /// Method to make http POST request which is a alias of [dio.fetch(RequestOptions)].
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
  /// [ErrorResult] with [NoConnectionError].
  Future<Result<T>> post<T>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    final Object? data = const {},
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions: this.options.loggerOptions,
      baseUrl: this.options.baseUrl ?? _dio.options.baseUrl,
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
    );
  }

  /// Method to make http PUT request which is a alias of [dio.fetch(RequestOptions)].
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
  /// [ErrorResult] with [NoConnectionError].
  Future<Result<T>> put<T>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    required final Object data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions: this.options.loggerOptions,
      baseUrl: this.options.baseUrl ?? _dio.options.baseUrl,
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
    );
  }

  /// Method to make http PATCH request which is a alias of [dio.fetch(RequestOptions)].
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
  /// [ErrorResult] with [NoConnectionError].
  Future<Result<T>> patch<T>(
    final String path,
    final T Function(Map<String, dynamic> json) fromJson, {
    required final Object data,
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
    final ProgressCallback? onSendProgress,
    final ProgressCallback? onReceiveProgress,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions: this.options.loggerOptions,
      baseUrl: this.options.baseUrl ?? _dio.options.baseUrl,
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
    );
  }

  /// Method to make http DELETE request which is a alias of [dio.fetch(RequestOptions)].
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
  /// [ErrorResult] with [NoConnectionError].
  Future<Result<T>> delete<T>(
    final String path, {
    final T Function(Map<String, dynamic> json)? fromJson,
    final Object? data = const {},
    final Map<String, dynamic>? queryParameters,
    final Options? options,
    final CancelToken? cancelToken,
  }) async {
    final NetworkLogInfo logInfo = NetworkLogInfo(
      loggerOptions: this.options.loggerOptions,
      baseUrl: this.options.baseUrl ?? _dio.options.baseUrl,
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
    );
  }

  /// Decoding [Response.data] data to the provided [T] generic type.
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

  T _decodeMap<T>(
    final Response response,
    final T Function(Map<String, dynamic> json) fromJson,
  ) {
    return fromJson(response.data);
  }

  T _decodeList<T>(
    final Response response,
    final T Function(Map<String, dynamic> json) fromJson,
  ) {
    final list = response.data as List;

    return List.from(list.map((item) => fromJson(item)).toList()) as T;
  }

  Future<Result<T>> _handleRequest<T>({
    required final Future<Response> request,
    required final T Function(Map<String, dynamic> json)? fromJson,
    required NetworkLogInfo logInfo,
  }) async {
    try {
      if (options.checkConnection && await options.connection.isNotConnected) {
        const error = NetworkError.connection();

        NetworkLogger.logError(logInfo.copyWith(error: error));

        return const Result.error(error: error);
      }

      final response = await request;
      logInfo = logInfo.copyWith(response: response);

      // final T data = _decode(response, fromJson);

      return Result.success(data: _decode(response, fromJson));
    } on TypeError catch (typeError, stackTrace) {
      final error = NetworkError.type(
        stackTrace: stackTrace,
        typeError: typeError,
      );

      NetworkLogger.logError(logInfo.copyWith(error: error));

      return Result.error(error: error);
    } on DioError catch (dioError, stackTrace) {
      final error = NetworkError.dio(
        stackTrace: stackTrace,
        dioError: dioError,
      );

      NetworkLogger.logError(logInfo.copyWith(error: error));

      return Result.error(error: error);
    }
  }
}
