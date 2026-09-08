import 'package:get/get.dart';
import '../data/datasources/radio_local_data_source.dart';
import '../data/repositories/radio_repository_impl.dart';
import '../domain/repositories/radio_repository.dart';
import '../domain/usecases/get_radio_state_usecase.dart';
import '../domain/usecases/get_chat_messages_usecase.dart';
import '../domain/usecases/send_chat_message_usecase.dart';
import '../presentation/controllers/radio_controller.dart';

class RadioBinding extends Bindings {
  @override
  void dependencies() {
    // Only register if not already registered
    if (!Get.isRegistered<RadioLocalDataSource>()) {
      Get.lazyPut<RadioLocalDataSource>(() => RadioLocalDataSourceImpl());
    }
    if (!Get.isRegistered<RadioRepository>()) {
      Get.lazyPut<RadioRepository>(
        () => RadioRepositoryImpl(Get.find<RadioLocalDataSource>()),
      );
    }
    if (!Get.isRegistered<GetRadioStateUseCase>()) {
      Get.lazyPut(() => GetRadioStateUseCase(Get.find<RadioRepository>()));
    }
    if (!Get.isRegistered<GetChatMessagesUseCase>()) {
      Get.lazyPut(() => GetChatMessagesUseCase(Get.find<RadioRepository>()));
    }
    if (!Get.isRegistered<SendChatMessageUseCase>()) {
      Get.lazyPut(() => SendChatMessageUseCase(Get.find<RadioRepository>()));
    }
    if (!Get.isRegistered<RadioController>()) {
      Get.lazyPut(
        () => RadioController(
          Get.find<GetRadioStateUseCase>(),
          Get.find<GetChatMessagesUseCase>(),
          Get.find<SendChatMessageUseCase>(),
        ),
      );
    }
  }
}
