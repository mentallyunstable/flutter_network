import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MockConnectivity extends Mock implements Connectivity {
  final ConnectivityResult result;

  MockConnectivity(this.result);

  @override
  Future<ConnectivityResult> checkConnectivity() async => result;
}
