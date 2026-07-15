import '../models/order_model.dart';
import '../models/tracking_event_model.dart';
import '../../domain/entities/order_stats_entity.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getMockOrders();
  Future<OrderDetailData> getMockOrderDetail(String orderId);
  Future<List<TrackingEventModel>> getMockTrackingEvents(String orderId);
  Future<OrderStatsEntity> getMockOrderStats();
}

class OrderDetailData {
  final OrderModel order;
  final List<TrackingEventModel> tracking;

  const OrderDetailData({required this.order, required this.tracking});
}
