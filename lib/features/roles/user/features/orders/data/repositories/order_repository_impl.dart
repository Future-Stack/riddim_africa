import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_stats_entity.dart';
import '../../domain/entities/tracking_event_entity.dart';
import '../datasources/order_local_data_source.dart';
import '../datasources/order_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource _localDataSource;
  final OrderRemoteDataSource _remoteDataSource;
  final Map<String, OrderEntity> _orderCache = {};

  OrderRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<List<OrderEntity>> getOrders({String status = 'All'}) async {
    try {
      final orders = await _remoteDataSource.getOrders(status: status);
      for (final order in orders) {
        _orderCache[order.id] = order;
      }
      return orders;
    } catch (_) {
      final mockOrders = await _localDataSource.getMockOrders();
      for (final order in mockOrders) {
        _orderCache[order.id] = order;
      }
      return mockOrders;
    }
  }

  @override
  Future<OrderEntity> getOrderDetail(String orderId) async {
    if (_orderCache.containsKey(orderId)) {
      return _orderCache[orderId]!;
    }
    final detail = await _localDataSource.getMockOrderDetail(orderId);
    return detail.order;
  }

  @override
  Future<List<TrackingEventEntity>> getTrackingEvents(
    String orderId,
  ) async {
    return await _localDataSource.getMockTrackingEvents(orderId);
  }

  @override
  Future<OrderStatsEntity> getOrderStats() async {
    return await _localDataSource.getMockOrderStats();
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _localDataSource.cancelOrder(orderId);
  }

  @override
  Future<void> confirmDelivery(String orderId) async {
    await _localDataSource.confirmDelivery(orderId);
  }
}
