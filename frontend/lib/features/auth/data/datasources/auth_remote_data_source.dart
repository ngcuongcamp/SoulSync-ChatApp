// ignore_for_file: dangling_library_doc_comments
/// Thực hiện lấy dữ liệu từ API

import 'dart:convert';
import 'package:soul_app/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = 'http://localhost:8686/auth';

  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'});

    final dataUser = jsonDecode(response.body)['result'];
    return UserModel.fromJson(dataUser);
  }

  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final responseData = jsonDecode(response.body);

    final dataUser = {
      'id': responseData['userId'],
      'username': username,
      'email': email,
    };

    return UserModel.fromJson(dataUser);
  }
}
