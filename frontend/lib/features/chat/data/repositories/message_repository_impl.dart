import 'package:soul_app/features/chat/data/datasource/messages_remote_data_source.dart';
import 'package:soul_app/features/chat/domain/entities/message_entity.dart';
import 'package:soul_app/features/chat/domain/repositories/message_repository.dart';

/**
 * là một lớp trong Dart, triển khai giao diện MessageRepository. Lớp này sử dụng MessagesRemoteDataSource để tương tác với API từ xa và thực hiện các thao tác liên quan đến tin nhắn.
 * 
 */

class MessageRepositoryImpl implements MessageRepository {
  final MessagesRemoteDataSource messagesRemoteDataSource;

  MessageRepositoryImpl({required this.messagesRemoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    return await messagesRemoteDataSource.fetchMessage(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    throw UnimplementedError();
  }
}
