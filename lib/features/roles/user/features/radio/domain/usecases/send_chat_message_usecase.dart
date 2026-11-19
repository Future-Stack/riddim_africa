import '../repositories/radio_repository.dart';

class SendChatMessageUseCase {
  final RadioRepository repository;

  SendChatMessageUseCase(this.repository);

  Future<void> execute(String message) {
    return repository.sendChatMessage(message);
  }
}
