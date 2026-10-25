import '../entities/order_entity.dart';
import '../entities/order_stats_entity.dart';
import '../entities/tracking_event_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrders({String status = 'All'});
  Future<OrderEntity> getOrderDetail(String orderId);
  Future<List<TrackingEventEntity>> getTrackingEvents(String orderId);
  Future<OrderStatsEntity> getOrderStats();
  Future<void> cancelOrder(String orderId);
  Future<void> confirmDelivery(String orderId);
}
