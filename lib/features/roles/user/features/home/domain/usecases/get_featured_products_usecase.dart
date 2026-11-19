import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';

class GetFeaturedProductsUseCase {
  final HomeRepository repository;

  GetFeaturedProductsUseCase(this.repository);

  Future<List<ProductEntity>> execute() {
    return repository.getFeaturedProducts();
  }
}
