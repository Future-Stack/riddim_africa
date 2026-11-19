import '../entities/chat_message_entity.dart';
import '../repositories/radio_repository.dart';

class GetChatMessagesUseCase {
  final RadioRepository repository;

  GetChatMessagesUseCase(this.repository);

  Stream<List<ChatMessageEntity>> execute() {
    return repository.getChatMessages();
  }
}
