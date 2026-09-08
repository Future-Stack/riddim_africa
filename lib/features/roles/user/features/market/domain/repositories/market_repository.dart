import '../entities/market_product_entity.dart';
import '../entities/cart_item_entity.dart';
import '../entities/delivery_address_entity.dart';

abstract class MarketRepository {
  Future<MarketProductEntity> getProductDetail(String productId);
  Future<List<MarketProductEntity>> getRelatedProducts(String productId);
  Future<List<CartItemEntity>> getCartItems();
  Future<List<DeliveryAddressEntity>> getDeliveryAddresses();
  Future<List<MarketProductEntity>> getArtistProducts(String artistName);
  Future<List<MarketProductEntity>> getMarketProducts();
}
