import 'package:soul_app/features/chat/domain/entities/message_entity.dart';

/**
 * `MessageModel` là một lớp đặc biệt sử dụng để biểu diễn dữ liệu tin nhắn, lớp này được mở rộng từ `MessageEntity`, một lớp đại diện cho thực thể tin nhắn miền `domain` của ứng dụng 
 * 
 */

/**
 * class `MessageModel` mở rộng từ `MessageEntity`, kế thừa tất cả các thuộc tính của `MessageEntity` 
 * - lớp này được sử dụng để biểu diễn dữ liệu tin nhấn trong tầng dữ liệu (data layer) của ứng dụng
 */
class MessageModel extends MessageEntity {
  /**
   * Constructor, nhận vào các tham số và truyền vào cho constuctor của lớp cha (`MessageEntity`) thông qua từ khóa `super` 
   */
  MessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.content,
    required super.createAt,
  });

  /**
   * factory MessageModel.fromJson(Map<String, dynamic> json):
   * 
   * - đây là một factory constuctor, được sử dụng để tao một instance của `MessageModel` với các gia trị lấy từ đối tượng JSON, chuyển từ đối tượng API sang đối tượng Dart
   * - nghĩa là: thay vì tạo một instance của MessageModel để convert từ JSON api sang đối tượng Dart thì ta sẽ gọi phương thức này từ class MessageModel 
   *   MessageModel message = MessageModel.fromJson(json);
   */

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversation_id'],
      senderId: json['sender_id'],
      content: json['content'],
      createAt: json['create_at'],
    );
  }
}
