import '../entities/delivery_address_entity.dart';
import '../repositories/market_repository.dart';

class GetDeliveryAddressesUseCase {
  final MarketRepository repository;

  GetDeliveryAddressesUseCase(this.repository);

  Future<List<DeliveryAddressEntity>> execute() {
    return repository.getDeliveryAddresses();
  }
}
