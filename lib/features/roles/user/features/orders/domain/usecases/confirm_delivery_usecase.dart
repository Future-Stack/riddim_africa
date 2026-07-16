import '../repositories/order_repository.dart';

class ConfirmDeliveryUseCase {
  final OrderRepository _repository;

  ConfirmDeliveryUseCase(this._repository);

  Future<void> execute(String orderId) => _repository.confirmDelivery(orderId);
}
