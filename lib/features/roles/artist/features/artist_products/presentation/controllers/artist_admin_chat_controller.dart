import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/artist_admin_chat_model.dart';

class ArtistAdminChatController extends GetxController {
  final String adminName = 'Kwame Asante';
  final String adminAvatar =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150';
  final bool isOnline = true;

  final RxList<ArtistChatMessageModel> messages = <ArtistChatMessageModel>[].obs;
  final TextEditingController messageInputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    messages.assignAll(ArtistChatMessageModel.getInitialMessages());
  }

  @override
  void onClose() {
    messageInputController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage() {
    final text = messageInputController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final timeFormatted = '$hour:$minute $period';

    final newMessage = ArtistChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      time: timeFormatted,
      isFromAdmin: false,
      senderAvatar:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    );

    messages.add(newMessage);
    messageInputController.clear();

    // Scroll to bottom (in reverse mode, 0.0 is the bottom)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
