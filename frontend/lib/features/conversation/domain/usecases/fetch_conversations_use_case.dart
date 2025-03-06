import '../repositories/conversation_repository.dart';
import '../entities/conversation_entity.dart';

class FetchConversationsUseCase {
  final ConversationsRepository repository;
  FetchConversationsUseCase({required this.repository});

  Future<List<ConversationEntity>> call() async {
    return repository.fetchConversations();
  }
}
