import '../models/order_model.dart';
import '../models/tracking_event_model.dart';
import '../../domain/entities/order_stats_entity.dart';
import 'order_local_data_source.dart';

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  static List<OrderModel>? _cachedOrders;

  List<OrderModel> _initOrders() {
    if (_cachedOrders != null) return _cachedOrders!;
    _cachedOrders = [
      OrderModel(
        id: 'ord_1',
        orderNumber: 'RA-2026-47281',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        title: 'Ankara Print Hoodie',
        sellerName: 'AfroStyle KLA',
        price: 'UGX 78,000',
        quantity: 1,
        selectedColor: 'Green',
        selectedSize: 'XL',
        statusLabel: 'Out for Delivery',
        expectedDelivery: '3-5 Business Days',
        estimatedDate: 'June 12, 2026',
        orderDate: DateTime(2026, 6, 10),
        shippingAddress: 'Plot 12, Buganda Road, Kampala',
        paymentMethod: 'Airtel Money',
        isPaid: true,
        deliveryFee: 'UGX 8,500',
        totalPrice: 'UGX 86,500',
      ),
      OrderModel(
        id: 'ord_2',
        orderNumber: 'RA-2026-35192',
        imageUrl:
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=500&auto=format&fit=crop',
        title: 'Beaded Necklace Set',
        sellerName: 'Heritage Jewels',
        price: 'UGX 35,000',
        quantity: 2,
        selectedColor: 'Blue',
        selectedSize: 'One Size',
        statusLabel: 'Delivered',
        expectedDelivery: '2-4 Business Days',
        estimatedDate: 'May 28, 2026',
        orderDate: DateTime(2026, 5, 26),
        shippingAddress: 'Kampala Road, Kampala',
        paymentMethod: 'MTN Mobile Money',
        isPaid: true,
        deliveryFee: 'UGX 9,000',
        totalPrice: 'UGX 79,000',
      ),
      OrderModel(
        id: 'ord_3',
        orderNumber: 'RA-2026-62400',
        imageUrl:
            'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?q=80&w=500&auto=format&fit=crop',
        title: 'Kente Cap Premium',
        sellerName: 'AfroStyle KLA',
        orderDate: DateTime(2026, 6, 12),
        price: 'UGX 38,000',
        quantity: 2,
        selectedColor: 'Gold',
        selectedSize: 'M',
        statusLabel: 'Active',
        expectedDelivery: '5-7 Business Days',
        estimatedDate: 'June 20-22, 2026',
        shippingAddress: 'Buganda Rd, Kampala',
        paymentMethod: 'Airtel Money',
        isPaid: true,
        deliveryFee: 'UGX 5,000',
        totalPrice: 'UGX 81,000',
      ),
      OrderModel(
        id: 'ord_4',
        orderNumber: 'RA-2026-61assad800',
        imageUrl:
            'https://images.unsplash.com/photo-1576566588028-09e027f7f1d2?q=80&w=500&auto=format&fit=crop',
        title: 'African Print Trousers',
        sellerName: 'AfroStyle KLA',
        price: 'UGX 58,000',
        orderDate: DateTime(2026, 5, 15),
        selectedColor: 'Blue',
        selectedSize: '32',
        statusLabel: 'Cancelled',
        expectedDelivery: '3-5 Business Days',
        estimatedDate: 'May 20-22, 2026',
        paymentMethod: 'Cash on Delivery',
        isPaid: false,
        deliveryFee: 'UGX 5,000',
        totalPrice: 'UGX 63,000',
      ),
    ];
    return _cachedOrders!;
  }

  @override
  Future<List<OrderModel>> getMockOrders() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _initOrders();
  }

  @override
  Future<OrderDetailData> getMockOrderDetail(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final orders = _initOrders();
    final order = orders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => orders.first,
    );

    final status = order.statusLabel.toLowerCase();
    final isCancelled = status == 'cancelled';
    final isDelivered = status == 'delivered';
    final isOutForDelivery = status == 'out for delivery';
    final isShipped = status == 'shipped';
    final isPreparing = status == 'preparing';

    final List<TrackingEventModel> trackingEvents;

    if (isCancelled) {
      trackingEvents = [
        const TrackingEventModel(
          title: 'Order Placed',
          description: 'June 10, 10:30 AM',
          date: '',
          isCompleted: true,
          isCurrent: false,
        ),
        const TrackingEventModel(
          title: 'Cancelled',
          description: 'Your order was cancelled',
          date: 'June 10, 11:30 AM',
          isCompleted: true,
          isCurrent: true,
        ),
      ];
    } else {
      trackingEvents = [
        const TrackingEventModel(
          title: 'Order Placed',
          description: 'June 10, 10:30 AM',
          date: '',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingEventModel(
          title: 'Order Confirmed',
          description: 'June 10, 11:15 AM',
          date: '',
          isCompleted: isOutForDelivery || isShipped || isPreparing || isDelivered,
          isCurrent: false,
        ),
        TrackingEventModel(
          title: 'Preparing',
          description: 'June 10, 2:00 PM',
          date: '',
          isCompleted: isOutForDelivery || isShipped || isDelivered,
          isCurrent: isPreparing,
        ),
        TrackingEventModel(
          title: 'Shipped',
          description: 'June 11, 9:00 AM',
          date: '',
          isCompleted: isOutForDelivery || isDelivered,
          isCurrent: isShipped,
        ),
        TrackingEventModel(
          title: 'Out for Delivery',
          description: 'June 12, 8:00 AM',
          date: '',
          isCompleted: isDelivered,
          isCurrent: isOutForDelivery,
        ),
        TrackingEventModel(
          title: 'Delivered',
          description: isDelivered ? 'June 12, 12:30 PM' : 'Expected June 13',
          date: '',
          isCompleted: isDelivered,
          isCurrent: false,
        ),
      ];
    }

    return OrderDetailData(
      order: order,
      tracking: trackingEvents,
    );
  }

  @override
  Future<List<TrackingEventModel>> getMockTrackingEvents(
    String orderId,
  ) async {
    return (await getMockOrderDetail(orderId)).tracking;
  }

  @override
  Future<OrderStatsEntity> getMockOrderStats() async {
    final orders = _initOrders();
    int active = 0;
    int delivered = 0;
    for (var o in orders) {
      final s = o.statusLabel.toLowerCase();
      if (s == 'delivered') {
        delivered++;
      } else if (s != 'cancelled' && s != 'canceled') {
        active++;
      }
    }

    return OrderStatsEntity(
      total: orders.length,
      processing: active,
      shipped: 0,
      delivered: delivered,
    );
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    final orders = _initOrders();
    final index = orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      orders[index] = orders[index].copyWith(statusLabel: 'Cancelled');
    }
  }

  @override
  Future<void> confirmDelivery(String orderId) async {
    final orders = _initOrders();
    final index = orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      orders[index] = orders[index].copyWith(statusLabel: 'Delivered');
    }
  }
}
