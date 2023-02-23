import 'package:dio/dio.dart';

import 'logger.dart';
import 'network_log_info.dart';

import '../options/logger_options.dart';

class NetworkLoggerInterceptor extends Interceptor {
  final NetworkLoggerOptions loggerOptions;

  NetworkLoggerInterceptor(this.loggerOptions);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final logInfo = _createLogInfo(options);

    NetworkLogger.logRequest(logInfo);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logInfo = _createLogInfo(response.requestOptions, response);

    NetworkLogger.logResponse(logInfo);

    super.onResponse(response, handler);
  }

  NetworkLogInfo _createLogInfo(RequestOptions options, [Response? response]) {
    return NetworkLogInfo(
      loggerOptions: loggerOptions,
      method: options.method,
      baseUrl: options.baseUrl,
      path: options.path,
      responseType: options.responseType,
      requestData: options.data,
      headers: options.headers,
      queryParameters: options.queryParameters,
      response: response,
    );
  }
}
