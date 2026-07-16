import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.timeAgo,
    required super.isUnread,
    required super.category,
    required super.iconPath,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      timeAgo: json['timeAgo'] as String,
      isUnread: json['isUnread'] as bool? ?? false,
      category: json['category'] as String,
      iconPath: json['iconPath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'timeAgo': timeAgo,
      'isUnread': isUnread,
      'category': category,
      'iconPath': iconPath,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? timeAgo,
    bool? isUnread,
    String? category,
    String? iconPath,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      timeAgo: timeAgo ?? this.timeAgo,
      isUnread: isUnread ?? this.isUnread,
      category: category ?? this.category,
      iconPath: iconPath ?? this.iconPath,
    );
  }
}
