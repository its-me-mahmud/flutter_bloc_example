import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepository {
  final baseUrl = 'http://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts({int startIndex, int limit}) async {
    final response = await http.get(
      '$baseUrl?_start=$startIndex&_limit=$limit',
    );
    if (response.statusCode != 200) {
      print('Failed to fetch the data!');
    }
    final posts = json.decode(response.body) as List;
    return posts.map((post) => PostModel.fromMap(post)).toList();
  }
}
