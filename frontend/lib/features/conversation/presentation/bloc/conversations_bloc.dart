import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_app/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:soul_app/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:soul_app/features/conversation/presentation/bloc/conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;

  ConversationsBloc(this.fetchConversationsUseCase)
      : super(ConversationsInitial()) {
    on<FetchConversations>(_onFetchConversations);
  }

  Future<void> _onFetchConversations(
      FetchConversations event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());
    try {
      final conversations = await fetchConversationsUseCase();
      emit(ConversationsLoaded(conversations: conversations));
    } catch (error) {
      emit(ConversationsError(error: 'Failed to load conversations!'));
    }
  }
}
