import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';

class GetTrendingProductsUseCase {
  final HomeRepository repository;

  GetTrendingProductsUseCase(this.repository);

  Future<List<ProductEntity>> execute() {
    return repository.getTrendingProducts();
  }
}
