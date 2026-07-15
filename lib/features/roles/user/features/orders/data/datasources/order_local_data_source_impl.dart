import '../models/order_model.dart';
import '../models/tracking_event_model.dart';
import '../../domain/entities/order_stats_entity.dart';
import 'order_local_data_source.dart';

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  @override
  Future<List<OrderModel>> getMockOrders() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      OrderModel(
        id: 'ord_1',
        orderNumber: 'RA-2026-62619',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        title: 'Ankara Print Hoodie',
        sellerName: 'AfroStyle KLA',
        price: 'UGX 78,000',
        quantity: 1,
        selectedColor: 'Red',
        selectedSize: 'XL',
        statusLabel: 'Shipped',
        expectedDelivery: '3-5 Business Days',
        estimatedDate: 'June 16-18, 2026',
        orderDate: DateTime(2026, 6, 10),
        shippingAddress: 'Buganda Rd, Kampala',
        paymentMethod: 'Airtel Money',
        isPaid: true,
      ),
      OrderModel(
        id: 'ord_2',
        orderNumber: 'RA-2026-62540',
        imageUrl:
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=500&auto=format&fit=crop',
        title: 'Masai Bracelet Set',
        orderDate: DateTime(2026, 6, 8),
        sellerName: 'Heritage Jewels',
        price: 'UGX 145,000',
        statusLabel: 'Shipped',
        expectedDelivery: '2-4 Business Days',
        estimatedDate: 'June 14-16, 2026',
        shippingAddress: 'Kampala Road, Kampala',
        paymentMethod: 'MTN Mobile Money',
        isPaid: true,
      ),
      OrderModel(
        id: 'ord_3',
        orderNumber: 'RA-2026-62400',
        imageUrl:
            'https://images.unsplash.com/photo-1588850561407-d208edebf8b7?q=80&w=500&auto=format&fit=crop',
        title: 'Kente Cap Premium',
        sellerName: 'AfroStyle KLA',
        orderDate: DateTime(2026, 6, 12),
        price: 'UGX 38,000',
        quantity: 2,
        selectedColor: 'Gold',
        selectedSize: 'M',
        statusLabel: 'Processing',
        expectedDelivery: '5-7 Business Days',
        estimatedDate: 'June 20-22, 2026',
        shippingAddress: 'Buganda Rd, Kampala',
        paymentMethod: 'Airtel Money',
        isPaid: true,
      ),
      OrderModel(
        id: 'ord_4',
        orderNumber: 'RA-2026-62200',
        imageUrl:
            'https://images.unsplash.com/photo-1503342217505-b0a15ec515c7?q=80&w=500&auto=format&fit=crop',
        title: 'Dashiki Shirt Classic',
        quantity: 1,
        selectedSize: 'L',
        orderDate: DateTime(2026, 5, 28),
        statusLabel: 'Delivered',
        sellerName: 'Craft Studio UG',
        price: 'UGX 65,000',
        expectedDelivery: '3-5 Business Days',
        estimatedDate: 'June 5-7, 2026',
        shippingAddress: 'Bea Town, Kampala',
        paymentMethod: 'MTN Mobile Money',
        isPaid: true,
      ),
      OrderModel(
        id: 'ord_5',
        orderNumber: 'RA-2026-61800',
        imageUrl:
            'https://images.unsplash.com/photo-1576566588028-09e027f7f1d2?q=80&w=500&auto=format&fit=crop',
        title: 'African Print Trousers',
        sellerName: 'AfroStyle KLA',
        price: 'UGX 55,000',
        orderDate: DateTime(2026, 5, 15),
        selectedColor: 'Blue',
        selectedSize: '32',
        statusLabel: 'Delivered',
        expectedDelivery: '3-5 Business Days',
        estimatedDate: 'May 20-22, 2026',
        paymentMethod: 'Cash on Delivery',
        isPaid: false,
      ),
      OrderModel(
        id: 'ord_5',
        orderNumber: 'RA-2026-61assad800',
        imageUrl:
            'https://images.unsplash.com/photo-1576566588028-09e027f7f1d2?q=80&w=500&auto=format&fit=crop',
        title: 'African Print Trousers',
        sellerName: 'AfroStyle KLA',
        price: 'UGX 58,000',
        orderDate: DateTime(2026, 5, 15),
        selectedColor: 'Blue',
        selectedSize: '32',
        statusLabel: 'Canceled',
        expectedDelivery: '3-5 Business Days',
        estimatedDate: 'May 20-22, 2026',
        paymentMethod: 'Cash on Delivery',
        isPaid: false,
      ),
    ];
  }

  @override
  Future<OrderDetailData> getMockOrderDetail(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final orders = await getMockOrders();
    final order = orders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => orders.first,
    );

    final isDelivered = order.statusLabel == 'Delivered';
    final isShipped = order.statusLabel == 'Shipped';
    final isProcessing = order.statusLabel == 'Processing';
    final isactive = order.statusLabel == 'Active';

    return OrderDetailData(
      order: order,
      tracking: [
        const TrackingEventModel(
          title: 'Order Placed',
          description: 'Your order has been placed successfully',
          date: 'Jun 10, 2026 - 02:30 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        const TrackingEventModel(
          title: 'Payment Confirmed',
          description: 'Payment has been confirmed',
          date: 'Jun 10, 2026 - 02:35 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingEventModel(
          title: 'Processing',
          description: 'Seller is preparing your order',
          date: 'Jun 11, 2026 - 09:00 AM',
          isCompleted: !isProcessing,
          isCurrent: isProcessing,
        ),
        TrackingEventModel(
          title: 'Shipped',
          description: 'Your order has been shipped',
          date: 'Jun 12, 2026 - 11:20 AM',
          isCompleted: isDelivered,
          isCurrent: isShipped,
        ),
        TrackingEventModel(
          title: 'Delivered',
          description: isDelivered
              ? 'Package delivered successfully'
              : 'Package delivery pending',
          date: isDelivered
              ? 'Jun 14, 2026 - 03:10 PM'
              : 'Estimated Jun 16-18',
          isCompleted: isDelivered,
          isCurrent: false,
        ),
      ],
    );
  }

  @override
  Future<List<TrackingEventModel>> getMockTrackingEvents(
    String orderId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return (await getMockOrderDetail(orderId)).tracking;
  }

  @override
  Future<OrderStatsEntity> getMockOrderStats() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const OrderStatsEntity(
      total: 5,
      processing: 1,
      shipped: 2,
      delivered: 2,
    );
  }
}
