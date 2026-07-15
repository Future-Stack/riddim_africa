import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_stats_entity.dart';
import '../../domain/entities/tracking_event_entity.dart';
import '../datasources/order_local_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource _dataSource;

  OrderRepositoryImpl(this._dataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    return await _dataSource.getMockOrders();
  }

  @override
  Future<OrderEntity> getOrderDetail(String orderId) async {
    final detail = await _dataSource.getMockOrderDetail(orderId);
    return detail.order;
  }

  @override
  Future<List<TrackingEventEntity>> getTrackingEvents(
    String orderId,
  ) async {
    return await _dataSource.getMockTrackingEvents(orderId);
  }

  @override
  Future<OrderStatsEntity> getOrderStats() async {
    return await _dataSource.getMockOrderStats();
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _dataSource.cancelOrder(orderId);
  }

  @override
  Future<void> confirmDelivery(String orderId) async {
    await _dataSource.confirmDelivery(orderId);
  }
}
