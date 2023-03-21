import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import 'package:flutter_network/flutter_network.dart';

import 'instance_test.dart';
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

    test('get request', () async {
      /// Get object
      final Result resultObject =
          await service.get<TestPost>('posts/1', TestPost.fromJson);

      expect(resultObject, isA<SuccessfulResult<TestPost>>());
      expect((resultObject as SuccessfulResult).data, isA<TestPost>());

      /// Get objects list
      final Result resultList = await service.get('users', TestUser.fromJson);

      expect(resultList, isA<SuccessfulResult>());
    }, tags: [requestsTag, validTag]);

    test('post request', () async {
      final post = TestPost(
        userId: 1,
        title: 'New post title',
        body: 'New post body',
      );

      final result = await service.post<TestPost>(
        'posts',
        TestPost.fromJson,
        data: post,
        options: Options(
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        ),
      );

      expect(result, isA<SuccessfulResult>());
      expect(
        (result as SuccessfulResult<TestPost>).data,
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

      final result = await service.put<TestPost>(
        'posts/1',
        TestPost.fromJson,
        data: post,
        options: Options(
          headers: {'Content-type': 'application/json; charset=UTF-8'},
        ),
      );

      expect(result, isA<SuccessfulResult>());
      expect((result as SuccessfulResult<TestPost>).data, post);
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

      final Result result =
          await service.get<TestPost>('posts/1', TestPost.fromJson);

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
      final Result result = await service.get('blank-url', TestPost.fromJson);

      expect(result, isA<ErrorResult>());
      final error = (result as ErrorResult).error;
      expect(error, isA<DioNetworkError>());
    }, tags: [requestsTag, invalidTag]);
  });
}

class MockConnectivity extends Mock implements Connectivity {
  final ConnectivityResult result;

  MockConnectivity(this.result);

  @override
  Future<ConnectivityResult> checkConnectivity() async => result;
}
