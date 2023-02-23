import '_network_error.dart';

class TypeNetworkError extends NetworkError {
  final TypeError typeError;

  const TypeNetworkError({required super.stackTrace, required this.typeError});
}
