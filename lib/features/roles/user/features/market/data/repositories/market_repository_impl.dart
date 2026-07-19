import '../../domain/entities/market_product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../datasources/market_local_data_source.dart';

class MarketRepositoryImpl implements MarketRepository {
  final MarketLocalDataSource localDataSource;

  MarketRepositoryImpl(this.localDataSource);

  @override
  Future<MarketProductEntity> getProductDetail(String productId) async {
    return localDataSource.getMockProductDetail(productId);
  }

  @override
  Future<List<MarketProductEntity>> getRelatedProducts(String productId) async {
    final models = await localDataSource.getMockRelatedProducts(productId);
    return models;
  }

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    return localDataSource.getMockCartItems();
  }

  @override
  Future<List<DeliveryAddressEntity>> getDeliveryAddresses() async {
    return localDataSource.getMockDeliveryAddresses();
  }

  @override
  Future<List<MarketProductEntity>> getArtistProducts(
    String artistName,
  ) async {
    return localDataSource.getMockArtistProducts(artistName);
  }

  @override
  Future<List<MarketProductEntity>> getMarketProducts() async {
    return localDataSource.getMockProducts();
  }
}
