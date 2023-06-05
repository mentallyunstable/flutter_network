import 'package:flutter_network/src/data/network_error/_network_error.dart';

import 'result.dart';
import 'error_data.dart';

class ErrorResult<T, E extends ErrorData> implements Result<T, E> {
  final NetworkError error;
  final E? data;

  const ErrorResult({required this.error, this.data});
}
