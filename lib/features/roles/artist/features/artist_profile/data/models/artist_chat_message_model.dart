class ArtistChatMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final String senderName;
  final String? avatarUrl;

  const ArtistChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isMe,
    required this.senderName,
    this.avatarUrl,
  });

  static List<ArtistChatMessage> get initialMessages => [
        ArtistChatMessage(
          id: 'msg-1',
          text: 'Hello! Welcome to Riddim Africa Artist Support. How can we assist you today?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          isMe: false,
          senderName: 'Riddim Support Agent',
        ),
      ];
}
