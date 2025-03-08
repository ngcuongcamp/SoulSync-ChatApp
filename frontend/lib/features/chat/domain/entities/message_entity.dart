class MessageEntity {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final String createAt;

  MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createAt,
  });
}
