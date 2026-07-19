import '../entities/market_product_entity.dart';
import '../repositories/market_repository.dart';

class GetMarketProductsUseCase {
  final MarketRepository repository;

  GetMarketProductsUseCase(this.repository);

  Future<List<MarketProductEntity>> execute() {
    return repository.getMarketProducts();
  }
}
