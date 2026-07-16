import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/radio_state_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/usecases/get_radio_state_usecase.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_chat_message_usecase.dart';

class RadioController extends GetxController {
  final GetRadioStateUseCase _getRadioStateUseCase;
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;

  RadioController(
    this._getRadioStateUseCase,
    this._getChatMessagesUseCase,
    this._sendChatMessageUseCase,
  );

  // Reactive states
  final radioState = Rxn<RadioStateEntity>();
  final chatMessages = <ChatMessageEntity>[].obs;
  final isPlaying = false.obs;
  final volume = 0.75.obs;
  final playDurationSeconds = 0.obs;
  final isMuted = false.obs;
  final isChatLoading = true.obs;

  // Text editing controller for chat
  final textController = TextEditingController();
  final scrollController = ScrollController();

  // Active playing timer & subscription
  Timer? _playbackTimer;
  StreamSubscription? _chatSubscription;
  double _preMuteVolume = 0.75;

  @override
  void onInit() {
    super.onInit();
    _loadRadioState();
    _subscribeToChat();
  }

  @override
  void onClose() {
    _playbackTimer?.cancel();
    _chatSubscription?.cancel();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _loadRadioState() async {
    try {
      final state = await _getRadioStateUseCase.execute();
      radioState.value = state;
      isPlaying.value = state.isPlaying;
      volume.value = state.volume;
      if (isPlaying.value) {
        _startPlaybackTimer();
      }
    } catch (e) {
      debugPrint("Error fetching radio state: $e");
    }
  }

  void _subscribeToChat() {
    isChatLoading.value = true;
    _chatSubscription = _getChatMessagesUseCase.execute().listen(
      (messages) {
        chatMessages.assignAll(messages);
        isChatLoading.value = false;
        // Scroll to bottom when new messages arrive
        _scrollToBottom();
      },
      onError: (err) {
        isChatLoading.value = false;
        debugPrint("Error listening to chat messages: $err");
      },
    );
  }

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value) {
      _startPlaybackTimer();
    } else {
      _playbackTimer?.cancel();
    }
    radioState.value = radioState.value?.copyWith(isPlaying: isPlaying.value);
  }

  void _startPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      playDurationSeconds.value++;
    });
  }

  void resetPlaybackTimer() {
    playDurationSeconds.value = 0;
  }

  void updateVolume(double val) {
    volume.value = val;
    if (val > 0) {
      isMuted.value = false;
    }
    radioState.value = radioState.value?.copyWith(volume: val);
  }

  void toggleMute() {
    if (isMuted.value) {
      volume.value = _preMuteVolume;
      isMuted.value = false;
    } else {
      _preMuteVolume = volume.value;
      volume.value = 0.0;
      isMuted.value = true;
    }
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    textController.clear();
    try {
      await _sendChatMessageUseCase.execute(text);
      _scrollToBottom();
    } catch (e) {
      debugPrint("Error sending message: $e");
    }
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  String formatDuration(int totalSeconds) {
    final minutes = (totalSeconds / 60).floor();
    final seconds = totalSeconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }
}
