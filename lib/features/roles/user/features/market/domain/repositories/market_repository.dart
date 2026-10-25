import '../entities/market_product_entity.dart';
import '../entities/cart_item_entity.dart';
import '../entities/delivery_address_entity.dart';
import '../entities/checkout_result_entity.dart';

abstract class MarketRepository {
  Future<MarketProductEntity> getProductDetail(String productId);
  Future<List<MarketProductEntity>> getRelatedProducts(String productId);
  Future<List<CartItemEntity>> getCartItems();
  Future<bool> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  });
  Future<List<DeliveryAddressEntity>> getDeliveryAddresses();
  Future<DeliveryAddressEntity> saveDeliveryAddress(DeliveryAddressEntity address);
  Future<DeliveryAddressEntity> updateDeliveryAddress(String id, DeliveryAddressEntity address);
  Future<CheckoutResultEntity> processCheckout({
    required String? shippingInfoId,
    required Map<String, dynamic> shippingDetails,
    required String paymentMethod,
    required String checkoutType,
    Map<String, dynamic>? directPurchase,
  });
  Future<List<MarketProductEntity>> getArtistProducts(String artistName);
  Future<List<MarketProductEntity>> getMarketProducts({
    int page = 1,
    int limit = 10,
    String? search,
    String? categoryId,
    String? collectionId,
    String? collectionTitle,
  });
}
