import '../entities/seller_recent_order_entity.dart';
import '../repositories/seller_home_repository.dart';

class GetSellerRecentOrdersUseCase {
  final SellerHomeRepository repository;

  GetSellerRecentOrdersUseCase(this.repository);

  Future<List<SellerRecentOrderEntity>> execute() {
    return repository.getRecentOrders();
  }
}
