import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/artist_chat_message_model.dart';

class ArtistChatController extends GetxController {
  final RxList<ArtistChatMessageModel> messages =
      ArtistChatMessageModel.initialChatMessages.obs;
  late TextEditingController messageInputController;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    messageInputController = TextEditingController();
  }

  void sendMessage() {
    final text = messageInputController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final timeStr = '$hour:$minute $period';

    final newMessage = ArtistChatMessageModel(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      time: timeStr,
      isFromAdmin: false,
    );

    messages.add(newMessage);
    messageInputController.clear();

    // Auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    messageInputController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
