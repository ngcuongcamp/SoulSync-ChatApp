import 'package:soul_app/features/conversation/data/datasources/conversations_remote_data_source.dart';
import 'package:soul_app/features/conversation/domain/entities/conversation_entity.dart';
import 'package:soul_app/features/conversation/domain/repositories/conversation_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsRemoteDataSource remoteDataSource;

  ConversationsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await remoteDataSource.fetchConversations();
  }
}
