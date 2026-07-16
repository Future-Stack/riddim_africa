class NotificationEntity {
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final bool isUnread;
  final String category; // 'orders', 'radio', 'artists'
  final String iconPath;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.isUnread,
    required this.category,
    required this.iconPath,
  });
}
