import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/artist_chat_message_model.dart';

class ArtistLiveChatController extends GetxController {
  final RxList<ArtistChatMessage> messages = <ArtistChatMessage>[].obs;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxBool isAgentTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    messages.assignAll(ArtistChatMessage.initialMessages);
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final userMsg = ArtistChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      timestamp: DateTime.now(),
      isMe: true,
      senderName: 'You',
    );

    messages.add(userMsg);
    textController.clear();
    _scrollToBottom();

    // Simulate Agent response
    isAgentTyping.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isAgentTyping.value = false;
      messages.add(
        ArtistChatMessage(
          id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
          text: 'Thank you for reaching out! Our team is reviewing your query and will assist you shortly.',
          timestamp: DateTime.now(),
          isMe: false,
          senderName: 'Riddim Support Agent',
        ),
      );
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
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
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
