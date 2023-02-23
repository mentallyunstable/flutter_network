import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import 'package:flutter_network/flutter_network.dart';

import 'instance_test.dart';

void main() {
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
            checkConnection: true,
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
      final Result resultList =
          await service.get('users/1/posts', TestPost.fromJson);

      expect(resultList, isA<SuccessfulResult>());
    });

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
    });

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
    });
    test('delete request', () async {
      final result = await service.delete('posts/1');

      expect(result, isA<SuccessfulResult>());
    });
  });
}

class TestPost {
  final int userId;
  final int? id;
  final String title;
  final String body;

  TestPost({
    required this.userId,
    required this.title,
    required this.body,
    this.id,
  });

  TestPost.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        if (id != null) 'id': id,
        'title': title,
        'body': body,
      };

  TestPost copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return TestPost(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  int get hashCode => Object.hash(userId, id, title, body);

  @override
  bool operator ==(Object other) =>
      other is TestPost &&
      runtimeType == other.runtimeType &&
      userId == other.userId &&
      id == other.id &&
      title == other.title &&
      body == other.body;
}

class MockConnectivity extends Mock implements Connectivity {
  final ConnectivityResult result;

  MockConnectivity(this.result);

  @override
  Future<ConnectivityResult> checkConnectivity() async => result;
}
