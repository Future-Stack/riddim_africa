import '../entities/market_product_entity.dart';
import '../repositories/market_repository.dart';

class GetMarketProductsUseCase {
  final MarketRepository repository;

  GetMarketProductsUseCase(this.repository);

  Future<List<MarketProductEntity>> execute({
    int page = 1,
    int limit = 10,
    String? search,
    String? categoryId,
    String? collectionId,
    String? collectionTitle,
  }) {
    return repository.getMarketProducts(
      page: page,
      limit: limit,
      search: search,
      categoryId: categoryId,
      collectionId: collectionId,
      collectionTitle: collectionTitle,
    );
  }
}
