class ChatMessageEntity {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String message;
  final DateTime timestamp;
  final bool isPresenter;
  final bool isPinned;

  const ChatMessageEntity({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.message,
    required this.timestamp,
    required this.isPresenter,
    this.isPinned = false,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? senderName,
    String? senderAvatar,
    String? message,
    DateTime? timestamp,
    bool? isPresenter,
    bool? isPinned,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isPresenter: isPresenter ?? this.isPresenter,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
