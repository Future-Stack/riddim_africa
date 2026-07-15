import '../entities/cart_item_entity.dart';
import '../repositories/market_repository.dart';

class GetCartItemsUseCase {
  final MarketRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartItemEntity>> execute() {
    return repository.getCartItems();
  }
}
