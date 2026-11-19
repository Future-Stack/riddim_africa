import '../entities/market_product_entity.dart';
import '../repositories/market_repository.dart';

class GetRelatedProductsUseCase {
  final MarketRepository repository;

  GetRelatedProductsUseCase(this.repository);

  Future<List<MarketProductEntity>> execute(String productId) {
    return repository.getRelatedProducts(productId);
  }
}
