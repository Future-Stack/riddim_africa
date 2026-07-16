import '../../domain/entities/radio_state_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/radio_repository.dart';
import '../datasources/radio_local_data_source.dart';

class RadioRepositoryImpl implements RadioRepository {
  final RadioLocalDataSource localDataSource;

  RadioRepositoryImpl(this.localDataSource);

  @override
  Future<RadioStateEntity> getRadioState() {
    return localDataSource.getRadioState();
  }

  @override
  Stream<List<ChatMessageEntity>> getChatMessages() {
    return localDataSource.getChatMessages();
  }

  @override
  Future<void> sendChatMessage(String message) {
    return localDataSource.sendChatMessage(message);
  }
}
