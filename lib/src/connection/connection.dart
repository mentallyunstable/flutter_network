import 'package:connectivity_plus/connectivity_plus.dart';

/// Providing internet connection state for the [NetworkService].
/// Wrapper above [Connectivity] from connectivity_plus package.
///
/// Use [isConnected] and [isNotConnected] static fields to quickly get
/// the status of the Internet connection
///
/// Also you can use [_connectivity] field for your own purposes
class Connection {
  const Connection({Connectivity? connectivity}) : _connectivity = connectivity;

  final Connectivity? _connectivity;

  /// You can use this [Connectivity] instance for your own purpose
  Connectivity get connectivity => _connectivity ?? Connectivity();

  /// Asynchronously provides internet connection state
  ///
  /// If true - has connection
  ///
  /// If false - no connection
  Future<bool> get isConnected async =>
      await connectivity.checkConnectivity() != ConnectivityResult.none;

  /// Asynchronously provides internet connection state
  ///
  /// If true - no connection
  ///
  /// If false - has connection
  Future<bool> get isNotConnected async =>
      await connectivity.checkConnectivity() == ConnectivityResult.none;
}
