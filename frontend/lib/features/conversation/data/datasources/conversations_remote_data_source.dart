import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soul_app/features/conversation/data/models/conversation_model.dart';

class ConversationsRemoteDataSource {
  final String baseUrl = 'http://localhost:8686';
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversations() async {
    String token = await _storage.read(key: 'token') ?? "";

    final response =
        await http.get(Uri.parse('$baseUrl/conversations'), headers: {
      'Authorization': 'Beare $token',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }
}
