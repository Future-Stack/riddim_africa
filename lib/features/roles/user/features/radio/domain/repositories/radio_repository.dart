import '../entities/radio_state_entity.dart';
import '../entities/chat_message_entity.dart';

abstract class RadioRepository {
  Future<RadioStateEntity> getRadioState();
  Stream<List<ChatMessageEntity>> getChatMessages();
  Future<void> sendChatMessage(String message);
}
