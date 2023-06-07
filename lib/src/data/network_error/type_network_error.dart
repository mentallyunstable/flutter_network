import 'network_error.dart';

/// Describes [NetworkError] when response data wasn't decoded because of [TypeError].
class TypeNetworkError extends NetworkError {
  final TypeError typeError;

  const TypeNetworkError({required super.stackTrace, required this.typeError});
}
