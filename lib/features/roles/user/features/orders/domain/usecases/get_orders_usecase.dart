import '../repositories/order_repository.dart';
import '../entities/order_entity.dart';

class GetOrdersUseCase {
  final OrderRepository _repository;

  GetOrdersUseCase(this._repository);

  Future<List<OrderEntity>> execute({String status = 'All'}) =>
      _repository.getOrders(status: status);
}
