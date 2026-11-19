import 'dart:async';
import '../models/radio_state_model.dart';
import '../models/chat_message_model.dart';

abstract class RadioLocalDataSource {
  Future<RadioStateModel> getRadioState();
  Stream<List<ChatMessageModel>> getChatMessages();
  Future<void> sendChatMessage(String message);
}

class RadioLocalDataSourceImpl implements RadioLocalDataSource {
  final _chatController = StreamController<List<ChatMessageModel>>.broadcast();
  final List<ChatMessageModel> _messages = [];
  Timer? _messageSimTimer;

  final List<Map<String, dynamic>> _extraMessagesMock = [
    {
      'senderName': 'Adeola',
      'message': 'Who else is listening from London? 🇬🇧',
      'isPresenter': false,
    },
    {
      'senderName': 'Kofi',
      'message': 'DJ Afro is killing it on the decks! 🔥',
      'isPresenter': false,
    },
    {
      'senderName': 'Zainab',
      'message': 'Midnight Blues vibe is too real 😴💙',
      'isPresenter': false,
    },
    {
      'senderName': 'DJ Kolade',
      'message': 'Up next we have a special request for Amaka! Stay tuned 🎵',
      'isPresenter': true,
    },
    {
      'senderName': 'Mustapha',
      'message': 'Ayyyy Wizkid coming up! 🕺',
      'isPresenter': false,
    },
    {
      'senderName': 'Chinedu',
      'message': 'Riddim Africa is the ultimate vibe tonight.',
      'isPresenter': false,
    },
  ];

  int _extraMessageIndex = 0;

  RadioLocalDataSourceImpl() {
    _initializeChat();
  }

  void _initializeChat() {
    final baseTime = DateTime.now().subtract(const Duration(minutes: 10));
    _messages.addAll([
      ChatMessageModel(
        id: '1',
        senderName: 'Tunde Fashola',
        senderAvatar: 'https://i.pravatar.cc/150?img=33',
        message: 'This mix is FIRE 🔥🔥',
        timestamp: baseTime.add(const Duration(minutes: 2)),
        isPresenter: false,
      ),
      ChatMessageModel(
        id: '2',
        senderName: 'Ngozi Eze',
        senderAvatar: 'https://i.pravatar.cc/150?img=34',
        message: 'Please play Essence by Wizkid 🙏',
        timestamp: baseTime.add(const Duration(minutes: 2)),
        isPresenter: false,
      ),
      ChatMessageModel(
        id: '3',
        senderName: 'Amaka Okonkwo',
        senderAvatar: 'https://i.pravatar.cc/150?img=35',
        message: 'Riddim Africa is the best radio platform in Nigeria fr',
        timestamp: baseTime.add(const Duration(minutes: 3)),
        isPresenter: false,
      ),
      ChatMessageModel(
        id: '4',
        senderName: 'DJ Kolade',
        senderAvatar: 'https://i.pravatar.cc/150?img=11',
        message: 'Request line is open! Drop your song requests here — we\'re playing the best Afrobeats all night',
        timestamp: baseTime.add(const Duration(minutes: 4)),
        isPresenter: true,
      ),
      ChatMessageModel(
        id: '5',
        senderName: 'Emeka Obi',
        senderAvatar: 'https://i.pravatar.cc/150?img=12',
        message: 'Burna Boy next please!!',
        timestamp: baseTime.add(const Duration(minutes: 5)),
        isPresenter: false,
      ),
      ChatMessageModel(
        id: '6',
        senderName: 'Funmilayo Adeyemi',
        senderAvatar: 'https://i.pravatar.cc/150?img=15',
        message: 'Can you play something by Teni? Love her energy',
        timestamp: baseTime.add(const Duration(minutes: 6)),
        isPresenter: false,
      ),
      ChatMessageModel(
        id: '7',
        senderName: 'Jide Adewale',
        senderAvatar: 'https://i.pravatar.cc/150?img=16',
        message: 'Lagos in the building 🙌🙌',
        timestamp: baseTime.add(const Duration(minutes: 7)),
        isPresenter: false,
      ),
      ChatMessageModel(
        id: '8',
        senderName: 'DJ Kolade',
        senderAvatar: 'https://i.pravatar.cc/150?img=11',
        message: 'Shoutout to @amaka_ph in Port Harcourt and everyone tuning in from Abuja! Love you all 🎤',
        timestamp: baseTime.add(const Duration(minutes: 8)),
        isPresenter: true,
      ),
      ChatMessageModel(
        id: '9',
        senderName: 'Chisom',
        senderAvatar: 'https://i.pravatar.cc/150?img=18',
        message: 'YESSS BURNA BOY NEXT 🙏🙏🙏',
        timestamp: baseTime.add(const Duration(minutes: 9)),
        isPresenter: false,
      ),
    ]);

    _chatController.add(List.from(_messages));

    _messageSimTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (_extraMessageIndex < _extraMessagesMock.length) {
        final mockMsg = _extraMessagesMock[_extraMessageIndex];
        final newMsg = ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderName: mockMsg['senderName'],
          senderAvatar: 'https://i.pravatar.cc/150?img=${30 + _extraMessageIndex}',
          message: mockMsg['message'],
          timestamp: DateTime.now(),
          isPresenter: mockMsg['isPresenter'],
        );
        _messages.add(newMsg);
        _chatController.add(List.from(_messages));
        _extraMessageIndex++;
      } else {
        _extraMessageIndex = 0;
      }
    });
  }

  @override
  Future<RadioStateModel> getRadioState() async {
    return const RadioStateModel(
      title: 'Wanjohi — Midnight Blues',
      subtitle: 'The Late Night Show with DJ Afro',
      listenerCount: 136,
      isLive: true,
      logoUrl: 'assets/images/logo.png',
      volume: 0.75,
      isPlaying: false,
    );
  }

  @override
  Stream<List<ChatMessageModel>> getChatMessages() {
    return _chatController.stream;
  }

  @override
  Future<void> sendChatMessage(String message) async {
    final userMsg = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderName: 'You',
      senderAvatar: 'https://i.pravatar.cc/150?img=10',
      message: message,
      timestamp: DateTime.now(),
      isPresenter: false,
    );
    _messages.add(userMsg);
    _chatController.add(List.from(_messages));

    Future.delayed(const Duration(seconds: 2), () {
      final responses = [
        "Vibe checks out! 😎",
        "Totally agree with @You!",
        "Riddim Africa goes hard tonight 🔥🔥🔥",
        "Let's gooo!"
      ];
      final random = DateTime.now().millisecondsSinceEpoch % responses.length;
      final autoReply = ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderName: 'AfroBeatFan',
        senderAvatar: 'https://i.pravatar.cc/150?img=25',
        message: responses[random],
        timestamp: DateTime.now(),
        isPresenter: false,
      );
      _messages.add(autoReply);
      _chatController.add(List.from(_messages));
    });
  }

  void dispose() {
    _messageSimTimer?.cancel();
    _chatController.close();
  }
}
