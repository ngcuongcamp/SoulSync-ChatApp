import 'package:soul_app/features/conversation/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.participantName,
    required super.lastMessage,
    required super.lastMessageTime,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    
    return ConversationModel(
      id: json['conversation_id'].toString(),
      participantName: json['participant_name'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'],
    );
  }
}
