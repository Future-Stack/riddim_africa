import '../repositories/order_repository.dart';
import '../entities/order_stats_entity.dart';

class GetOrderStatsUseCase {
  final OrderRepository _repository;

  GetOrderStatsUseCase(this._repository);

  Future<OrderStatsEntity> execute() => _repository.getOrderStats();
}
