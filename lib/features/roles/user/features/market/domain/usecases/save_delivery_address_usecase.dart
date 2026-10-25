import '../entities/delivery_address_entity.dart';
import '../repositories/market_repository.dart';

class SaveDeliveryAddressUseCase {
  final MarketRepository _repository;

  SaveDeliveryAddressUseCase(this._repository);

  Future<DeliveryAddressEntity> execute(DeliveryAddressEntity address) {
    return _repository.saveDeliveryAddress(address);
  }
}
