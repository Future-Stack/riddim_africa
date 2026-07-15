import '../repositories/order_repository.dart';
import '../entities/order_entity.dart';

class GetOrderDetailUseCase {
  final OrderRepository _repository;

  GetOrderDetailUseCase(this._repository);

  Future<OrderEntity> execute(String orderId) =>
      _repository.getOrderDetail(orderId);
}
