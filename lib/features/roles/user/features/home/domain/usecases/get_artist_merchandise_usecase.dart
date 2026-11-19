import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';

class GetArtistMerchandiseUseCase {
  final HomeRepository repository;

  GetArtistMerchandiseUseCase(this.repository);

  Future<List<ProductEntity>> execute() {
    return repository.getArtistMerchandise();
  }
}
