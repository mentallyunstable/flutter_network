import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart' show Options;
import 'package:connectivity_plus/connectivity_plus.dart'
    show ConnectivityResult;

import 'package:flutter_network/flutter_network.dart';

import 'instance_test.dart';
import 'mock_connectivity.dart';
import 'models.dart';

void main() {
  const requestsTag = 'requests';
  const validTag = 'valid';
  const invalidTag = 'invalid';

  late NetworkOptions options;
  late NetworkService service;
  late Connection connection;

  group('Valid requests', () {
    setUp(() => {
          connection = Connection(
            connectivity: MockConnectivity(ConnectivityResult.wifi),
          ),
          options = NetworkOptions(
            baseUrl: baseUrl,
            connection: connection,
          ),
          service = NetworkService(options),
        });

    test('get request object', () async {
      /// Get object
      final result = await service.get('posts/1', TestPost.fromJson);

      expect(result, isA<SuccessfulResult>());
      expect((result as SuccessfulResult).data, isA<TestPost>());
    }, tags: [requestsTag, validTag]);

    test('get request list', () async {
      /// Get objects list
      final Result result = await service.get('users', TestUser.fromJson);

      expect(result, isA<SuccessfulResult>());
    });

    test('post request', () async {
      final post = TestPost(
        userId: 1,
        title: 'New post title',
        body: 'New post body',
      );

      final result = await service.post(
        'posts',
        TestPost.fromJson,
        data: post,
        options: Options(
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        ),
      );

      expect(result, isA<SuccessfulResult>());
      expect(
        (result as SuccessfulResult).data,
        post.copyWith(id: 101),
      );
    }, tags: [requestsTag, validTag]);

    test('put request', () async {
      final post = TestPost(
        id: 1,
        userId: 1,
        title: 'Put post title',
        body: 'Put post body',
      );

      final result = await service.put(
        'posts/1',
        TestPost.fromJson,
        data: post,
        options: Options(
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        ),
      );

      expect(result, isA<SuccessfulResult>());
      expect((result as SuccessfulResult).data, post);
    }, tags: [requestsTag, validTag]);

    test('delete request', () async {
      final result = await service.delete('posts/1');

      expect(result, isA<SuccessfulResult>());
    }, tags: [requestsTag, validTag]);
  });

  group('Invalid requests', () {
    setUp(() => {
          connection = Connection(
            connectivity: MockConnectivity(ConnectivityResult.wifi),
          ),
          options = NetworkOptions(
            baseUrl: baseUrl,
            connection: connection,
          ),
          service = NetworkService(options),
        });

    test('connection error', () async {
      final mockOptions = options.copyWith(
          connection: Connection(
        connectivity: MockConnectivity(ConnectivityResult.none),
      ));
      service = NetworkService(mockOptions);

      final Result result = await service.get('posts/1', TestPost.fromJson);

      expect(result, isA<ErrorResult>());
      final error = (result as ErrorResult).error;
      expect(error, isA<ConnectionNetworkError>());
    }, tags: [requestsTag, invalidTag]);

    test('type error', () async {
      final Result result = await service.get('posts/1', TestUser.fromJson);

      expect(result, isA<ErrorResult>());
      final error = (result as ErrorResult).error;
      expect(error, isA<TypeNetworkError>());
    }, tags: [requestsTag, invalidTag]);

    test('dio error', () async {
      NetworkOptions<TestErrorData> networkOptions = NetworkOptions(
        baseUrl: 'https://api.coincap.io/v2/',
        connection: connection,
        errorDataFromJson: TestErrorData.fromJson,
      );
      service = NetworkService(networkOptions);

      final result = await service.get<TestPost, TestErrorData>(
        'assets/%7B%7Basset_id%7D%7D/markets?',
        TestPost.fromJson,
      );

      expect(result, isA<ErrorResult>());
      if (result is ErrorResult<TestPost, TestErrorData>) {
        final error = result.error;
        expect(error, isA<DioNetworkError>());

        expect(result.data, isA<TestErrorData>());

        final errorData = result.data!;

        expect(errorData.error, '{{asset_id}} not found');
      }
    }, tags: [requestsTag, invalidTag]);
  });
}
