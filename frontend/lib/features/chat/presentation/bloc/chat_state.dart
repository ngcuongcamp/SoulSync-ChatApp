import 'package:soul_app/features/chat/domain/entities/message_entity.dart';

abstract class ChatState {}

class ChatLoadingState extends ChatState {
  final List<MessageEntity> message;

  ChatLoadingState(this.message);
}

class ChatErrorState extends ChatState {
  final Map<String, dynamic> message;

  ChatErrorState(this.message);
}
