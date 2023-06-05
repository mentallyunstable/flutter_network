import 'package:flutter_network/flutter_network.dart';

class SuccessfulResult<T, E extends ErrorData> implements Result<T, E> {
  final T? data;

  const SuccessfulResult({required this.data});
}
