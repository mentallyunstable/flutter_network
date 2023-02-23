import 'package:flutter_network/src/data/network_error/_network_error.dart';

import 'result.dart';

class ErrorResult<T> implements Result<T> {
  final NetworkError error;

  const ErrorResult({required this.error});
}
