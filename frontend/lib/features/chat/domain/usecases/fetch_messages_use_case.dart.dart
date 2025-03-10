import 'package:soul_app/features/chat/domain/entities/message_entity.dart';
import 'package:soul_app/features/chat/domain/repositories/message_repository.dart';

/**
 * NOTE: ```FetchMessagesUseCase``` là một lớp sử dụng để thực hiện thao tác lấy tin nhắn cho một người trò chuyện cụ thể
 * ```MessageRepository```  sử dụng để truy suất dữ liệu tin nhắn 
 */

class FetchMessagesUseCase {
  final MessageRepository repository;

  FetchMessagesUseCase({required this.repository});

  Future<List<MessageEntity>> call(String conversationId) async {
    return repository.fetchMessages(conversationId);
  }
}

/**
 * TODO: `repository` là một `instance` của `MessageRepository`, sử dụng để truy xuất dữ liệu tin nhắn 
 * 
 * TODO: `FetchMessagesUseCase({required this.repository})`: là một constructor của lớp `FetchMessagesUseCase`, yêu cầu một đối tượng `MessageRepository` khi khởi tạo
 * 
 * TODO: `Future<List<MessageEntity>> call(String conversationId)`
 * - đây là phương thức của lớp `FetchMessagesUseCase`, nhận vào `conversationId` làm tham số và trả về một `Future` chứa danh sách các đối tượng `MessageEntity`
 * - nó gọi phương thức `FetchMessages` của `repository` để lấy dữ liệu tin nhắn từ nguồn dữ liệu
 */
