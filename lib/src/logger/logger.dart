import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../data/data.dart';

import 'network_log_info.dart';

class NetworkLogger {
  /// Unicode symbols for pretty logging
  static const _boxDownRight = '\u250F';
  static const _boxDownLeft = '\u2513';
  static const _boxUpRight = '\u2517';
  static const _boxUpLeft = '\u251B';
  static const _horizontalLineSymbol = '\u2501';
  static const _verticalLineSymbol = '\u2503';
  static const _pointLeftSymbol = '\u252B';
  static const _pointRightSymbol = '\u2523';
  static const _doublePointerRight = '$_pointRightSymbol$_horizontalLineSymbol';

  static const _indent = '  ';

  static void logRequest(final NetworkLogInfo info) {
    if (!info.loggerOptions.printRequest) {
      return;
    }

    _printHeader('request');
    _printBaseInfo(info);
    if (info.requestData != null) {
      _printInfo(title: 'request data');
      if (info.requestData is Map) {
        _printMap(info.requestData as Map);
      } else {
        _printMap(jsonDecode(info.requestData as String));
      }
    }
    _printFooter();
  }

  static void logResponse(final NetworkLogInfo info) {
    if (!info.loggerOptions.printResponse) {
      return;
    }

    _printHeader('response');
    _printBaseInfo(info);
    _printInfo(title: 'status code', info: info.response?.statusCode);
    _printInfoIfNotNull('statusMessage', info.response?.statusMessage);
    _printInfoMap('extra', info.response?.extra);
    if (info.loggerOptions.printResponseHeaders) {
      _printInfoMap('response headers', info.response?.headers.map);
    }
    _printResponse(info);
    _printFooter();
  }

  static void _printBaseInfo(final NetworkLogInfo info) {
    _printInfo(title: 'method', info: info.method);
    _printInfo(title: 'url', info: info.url);
    _printInfo(title: 'responseType', info: info.responseType);
    _printInfoMap('headers', info.headers);
    _printInfoMap('queryParameters', info.queryParameters);
  }

  static void logError(final NetworkLogInfo info) {
    if (!info.loggerOptions.printError) {
      return;
    }

    _printHeader('error');
    _printInfo(title: 'method', info: info.method);
    _printInfo(title: 'url', info: info.url);
    _printInfo(title: 'error type', info: info.error.runtimeType);
    _printErrorMessage(info.error);
    _printFooter('StackTrace of the error will be logged under');
    _debugPrint(info.error!.stackTrace);
  }

  static void _printHeader(final String header) {
    _debugPrint(
      '$_boxDownRight${_horizontalLineSymbol * 5}$_pointLeftSymbol'
      ' NetworkService $header '
      '$_pointRightSymbol${_horizontalLineSymbol * 5}$_boxDownLeft',
    );
  }

  static void _printInfo({
    final String? title,
    final dynamic info,
    final bool withPointer = true,
  }) {
    _debugPrint('${withPointer ? _pointRightSymbol : _verticalLineSymbol} '
        '${title != null ? '$title: ' : ''}${info ?? ''}');
  }

  static void _printInfoIfNotNull(final String title, [final dynamic info]) {
    if (info != null) {
      _debugPrint('$_pointRightSymbol $title: $info');
    }
  }

  static void _printSubInfo(final dynamic info, [final int subLevels = 1]) {
    _debugPrint('$_pointRightSymbol${_horizontalLineSymbol * subLevels} $info');
  }

  static void _printFooter([final String? additionalInfo]) {
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write(_boxUpRight + _horizontalLineSymbol * 5);
    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      stringBuffer.write(' $additionalInfo');
    }

    _debugPrint(stringBuffer.toString());
  }

  static void _printInfoMap(
    final String title,
    final Map<String, dynamic>? info,
  ) {
    _printInfo(title: title);
    if (info != null) {
      info.forEach((key, value) => _printSubInfo('$key: $value'));
    }
  }

  static void _printResponse(final NetworkLogInfo info) {
    if (info.loggerOptions.printResponseBody) {
      _printInfo(title: 'response data');
      final data = info.response!.data;
      if (data is Map) {
        _printMap(data);

        return;
      }
      if (data is List) {
        _printList(data);

        return;
      }

      _printInfo(title: 'response data', info: info.response?.data.toString());
    }
  }

  static void _printList(
    final List data, {
    final int indentAmount = 1,
    final bool isNested = false,
    final bool addComma = false,
    final bool hasOpenBracket = true,
  }) {
    if (hasOpenBracket) {
      _debugPrint('$_verticalLineSymbol[');
    }

    var counter = 0;
    for (var entry in data) {
      final isLast = counter++ == data.length - 1;

      if (entry is Map) {
        _printMap(
          entry,
          isNested: true,
          addComma: !isLast,
          indentAmount: indentAmount + 1,
        );
      } else {
        _printInfo(info: entry);
      }
    }
    _debugPrint(
        '$_verticalLineSymbol${isNested ? _indent * (indentAmount - 1) : ''}]'
        '${addComma ? ',' : ''}');
  }

  static void _printMap(
    final Map map, {
    final int indentAmount = 1,
    final bool isNested = false,
    final bool addComma = false,
    final bool hasOpenBracket = true,
  }) {
    if (hasOpenBracket) {
      _debugPrint(
          '$_verticalLineSymbol${isNested ? _indent * (indentAmount - 1) : ''}{');
    }

    var counter = 0;
    map.forEach((key, value) {
      final isLast = counter++ == map.length - 1;
      final keyPrint = '$_verticalLineSymbol${_indent * (indentAmount)}$key: ';

      /// If value is String, split it by '\n' (line feed) symbol and print each line
      if (value is String) {
        final split = value.split('\n');

        if (split.length > 1) {
          final buffer = StringBuffer();

          buffer.write('$keyPrint"${split[0]}\n');

          for (int i = 1; i < split.length; i++) {
            /// ': ' = 2 symbols for indent
            buffer.write(
                '$_verticalLineSymbol${_indent * indentAmount + ' ' * (key.length + 2)}');
            buffer.write(split[i]);
            if (i != split.length - 1) {
              buffer.write('\n');
            }
          }

          buffer.write('"');
          if (!isLast) {
            buffer.write(',');
          }

          _debugPrint(buffer.toString());
          buffer.clear();

          return;
        }

        _debugPrint(
            '$keyPrint"${split[0]}"${split.length == 1 && !isLast ? ',' : ''}');

        return;
      }

      if (value is Map) {
        _debugPrint('$keyPrint{');
        _printMap(
          value,
          isNested: true,
          hasOpenBracket: false,
          addComma: !isLast,
          indentAmount: indentAmount + 1,
        );

        return;
      }

      if (value is List) {
        _debugPrint('$keyPrint[');
        _printList(
          value,
          isNested: true,
          hasOpenBracket: false,
          addComma: !isLast,
          indentAmount: indentAmount + 1,
        );

        return;
      }

      _debugPrint('$keyPrint$value${isLast ? '' : ','}');
    });

    _debugPrint(
        '$_verticalLineSymbol${isNested ? _indent * (indentAmount - 1) : ''}}'
        '${addComma ? ',' : ''}');
  }

  static void _printErrorMessage(final NetworkError? error) {
    if (error is TypeNetworkError) {
      _printInfo(title: 'error message', info: error.typeError);
    }

    if (error is DioNetworkError) {
      _printInfo(title: 'DioErrorType', info: error.dioError.type);
      _printInfo(title: 'error message', info: error.dioError.message);
      if (error.dioError.type != DioErrorType.unknown) {
        _printInfo(title: 'error response');
        final response = error.dioError.response;
        if (response == null) {
          return;
        }
        if (response.data is Map) {
          _printMap(response.data as Map);
        }
      }
    }
  }

  static void _debugPrint(final dynamic object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
