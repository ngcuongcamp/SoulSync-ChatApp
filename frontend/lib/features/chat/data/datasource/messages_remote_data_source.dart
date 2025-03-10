import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soul_app/features/chat/data/models/message_model.dart';
import 'package:soul_app/features/chat/domain/entities/message_entity.dart';
import 'package:http/http.dart' as http;

/**
 * `MessagesRemoteDataSource` là một lớp được sử dụng để tương tác với API từ xa để lấy dữ liệu tin nhắn. Lớp này sử dụng HTTP để gửi yêu cầu đến API và nhận phản hồi, sau đó chuyển đổi dữ liệu JSON từ phản hồi thành các đối tượng
 * 
 */

class MessagesRemoteDataSource {
  final String baseUrl = 'http://localhost:8686';
  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessage(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
        Uri.parse(
          '$baseUrl/messages/$conversationId',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
