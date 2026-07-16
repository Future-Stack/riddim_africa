import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.senderName,
    required super.senderAvatar,
    required super.message,
    required super.timestamp,
    required super.isPresenter,
    super.isPinned,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      senderName: json['senderName'] ?? '',
      senderAvatar: json['senderAvatar'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isPresenter: json['isPresenter'] ?? false,
      isPinned: json['isPinned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isPresenter': isPresenter,
      'isPinned': isPinned,
    };
  }
}
