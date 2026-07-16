import '../entities/market_product_entity.dart';
import '../repositories/market_repository.dart';

class GetArtistProductsUseCase {
  final MarketRepository repository;

  GetArtistProductsUseCase(this.repository);

  Future<List<MarketProductEntity>> execute(String artistName) {
    return repository.getArtistProducts(artistName);
  }
}
