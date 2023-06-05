import 'package:flutter_network/src/data/result/error_data.dart';

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

class TestUser {
  final int id;
  final String name;
  final String username;
  final String email;
  final TestAddress address;

  TestUser(this.id, this.name, this.username, this.email, this.address);

  TestUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        address = TestAddress.fromJson(json['address']);
}

class TestAddress {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final TestGeo geo;

  TestAddress(this.street, this.suite, this.city, this.zipcode, this.geo);

  TestAddress.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        suite = json['suite'],
        city = json['city'],
        zipcode = json['zipcode'],
        geo = TestGeo.fromJson(json['geo']);
}

class TestGeo {
  final String lat;
  final String lng;

  const TestGeo(this.lat, this.lng);

  TestGeo.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];
}

class TestErrorData implements ErrorData {
  final String error;
  final int timestamp;

  TestErrorData(this.error, this.timestamp);

  TestErrorData.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        timestamp = json['timestamp'];
}
