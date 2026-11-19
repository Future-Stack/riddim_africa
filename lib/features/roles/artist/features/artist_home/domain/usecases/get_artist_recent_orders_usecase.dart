import '../entities/artist_recent_order_entity.dart';
import '../repositories/artist_home_repository.dart';

class GetArtistRecentOrdersUseCase {
  final ArtistHomeRepository repository;

  GetArtistRecentOrdersUseCase(this.repository);

  Future<List<ArtistRecentOrderEntity>> execute() {
    return repository.getRecentOrders();
  }
}
