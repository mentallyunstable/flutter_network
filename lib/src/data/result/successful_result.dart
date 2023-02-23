import 'result.dart';

class SuccessfulResult<T> implements Result<T> {
  final T? data;

  const SuccessfulResult({required this.data});
}
