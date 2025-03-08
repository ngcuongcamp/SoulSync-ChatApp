// ignore_for_file: slash_for_doc_comments
/**
 * NOTE: `MessageRepository` 
 * - là một lớp trừu tượng (abstract class), định nghĩa một hợp đồng
 * - nó chứa hai phương thức trừu tượng mà bất kỳ lớp cụ thể nào mở rộng `MessageRepository` đều phải triển khai
 */

import 'package:soul_app/features/chat/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> fetchMessages(String conversationId);
  Future<void> sendMessage(MessageEntity message);
}

/**
 * 
 * TODO: 🔥`fetchMessage` là phương thức dùng để lấy tin nhắn cho một ID cuộc họp
 *  - phương thức này nhận vào một 🔥`conversationId` làm tham số và trả về một 🔥`Future` chứa danh sách các đối tượng 🔥`MessageEntity`
 * --> nó được sử dụng để lấy tất các các tin nhắn liên quan đến một cuộc trò chuyện cụ thể
 * 
 * TODO: 🔥`sendMessage` là phương thức dùng để gửi tin nhắn 
 * - phương thức này nhận một instance của class 🔥`MessageEntity` làm tham số và trả về một 🔥Future<void>
 * 
 */
