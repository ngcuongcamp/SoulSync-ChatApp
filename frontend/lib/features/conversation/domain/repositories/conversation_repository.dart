import '../entities/conversation_entity.dart';

abstract class ConversationsRepository {
  Future<List<ConversationEntity>> fetchConversations();
}
