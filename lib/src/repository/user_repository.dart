import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserRepository {
  final _baseUrl = 'http://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(_baseUrl);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch users!');
    }
    final users = json.decode(response.body) as List;
    return users.map((user) => UserModel.fromMap(user)).toList();
  }
}
