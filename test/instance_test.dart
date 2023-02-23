import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_network/flutter_network.dart';

const baseUrl = 'https://jsonplaceholder.typicode.com/';

void main() {
  group('Network service', () {
    test('create options and service instances', () {
      late NetworkOptions options;
      late NetworkService service;

      options = const NetworkOptions(baseUrl: baseUrl, checkConnection: false);

      expect(options.baseUrl, baseUrl);
      expect(options.checkConnection, false);

      service = NetworkService(options);

      expect(service.options, options);
    });
  });
}
