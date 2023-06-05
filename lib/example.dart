import 'package:flutter_network/flutter_network.dart';

const String baseUrl = 'https://jsonplaceholder.com';

Future getUser() async {
  final service = NetworkService(const NetworkOptions(baseUrl: baseUrl));

  final Result result = await service.get('/posts/1', Post.fromJson);

  /// handle successful result with decoded data
  if (result is SuccessfulResult) {
    final post = result.data!;

    print('Successful response, post title: ${post.title}');
  }

  /// handle error result with provided error
  if (result is ErrorResult) {
    final error = result.error;

    if (error is ConnectionNetworkError) {
      /// no internet connection, show no connection message
    }

    if (error is TypeNetworkError) {
      /// response data can't be decoded to provided fromJson argument, send error analytics
    }

    if (error is DioNetworkError) {
      /// invalid request or response statusCode is >= 400, show error message
    }
  }
}

class Post {
  final int userId;
  final int? id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.title,
    required this.body,
    this.id,
  });

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];
}
