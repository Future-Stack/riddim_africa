import '../entities/market_product_entity.dart';
import '../repositories/market_repository.dart';

class GetProductDetailUseCase {
  final MarketRepository repository;

  GetProductDetailUseCase(this.repository);

  Future<MarketProductEntity> execute(String productId) {
    return repository.getProductDetail(productId);
  }
}
