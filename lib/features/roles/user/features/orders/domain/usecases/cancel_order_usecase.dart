import '../repositories/order_repository.dart';

class CancelOrderUseCase {
  final OrderRepository _repository;

  CancelOrderUseCase(this._repository);

  Future<void> execute(String orderId) => _repository.cancelOrder(orderId);
}
