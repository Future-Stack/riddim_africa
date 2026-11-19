import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final selectedCategory = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleNotifications();
  }

  void _loadSampleNotifications() {
    notifications.assignAll([
      NotificationModel(
        id: '1',
        title: 'Order Shipped!',
        subtitle: 'Your Ankara Print Hoodie is on the way. Expected delivery June 13.',
        timeAgo: '2 hours ago',
        isUnread: true,
        category: 'orders',
        iconPath: IconPath.box,
      ),
      NotificationModel(
        id: '2',
        title: 'Order Confirmed',
        subtitle: 'Your order RA-2026-47281 has been confirmed.',
        timeAgo: '2 days ago',
        isUnread: false,
        category: 'orders',
        iconPath: IconPath.box,
      ),
      NotificationModel(
        id: '3',
        title: 'New Episode Out!',
        subtitle: 'Listen to the latest Riddim Africa Radio episode featuring DJ Kaleb.',
        timeAgo: '5 hours ago',
        isUnread: true,
        category: 'radio',
        iconPath: IconPath.radio,
      ),
      NotificationModel(
        id: '4',
        title: 'Trending Mixes',
        subtitle: 'Check out the top 5 Afrobeat mixes of the week.',
        timeAgo: '1 day ago',
        isUnread: false,
        category: 'radio',
        iconPath: IconPath.radio,
      ),
      NotificationModel(
        id: '5',
        title: 'Burna Boy Live',
        subtitle: 'Burna Boy just added a new concert date in Kampala. Get tickets now!',
        timeAgo: '1 day ago',
        isUnread: true,
        category: 'artists',
        iconPath: IconPath.profile,
      ),
      NotificationModel(
        id: '6',
        title: 'Wizkid Album Launch',
        subtitle: 'Wizkid\'s new album is now streaming. Listen now!',
        timeAgo: '3 days ago',
        isUnread: false,
        category: 'artists',
        iconPath: IconPath.profile,
      ),
    ]);
  }

  int get unreadCount => notifications.where((n) => n.isUnread).length;

  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (notifications[i].isUnread) {
        notifications[i] = notifications[i].copyWith(isUnread: false);
      }
    }
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1 && notifications[index].isUnread) {
      notifications[index] = notifications[index].copyWith(isUnread: false);
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  List<NotificationModel> get filteredNotifications {
    if (selectedCategory.value == 'all') {
      return notifications;
    }
    return notifications
        .where((n) => n.category == selectedCategory.value)
        .toList();
  }
}
