import '../models/market_product_model.dart';
import '../models/cart_item_model.dart';
import '../models/delivery_address_model.dart';

abstract class MarketLocalDataSource {
  Future<MarketProductModel> getMockProductDetail(String productId);
  Future<List<MarketProductModel>> getMockRelatedProducts(String productId);
  Future<List<CartItemModel>> getMockCartItems();
  Future<List<DeliveryAddressModel>> getMockDeliveryAddresses();
}

class MarketLocalDataSourceImpl implements MarketLocalDataSource {
  @override
  Future<MarketProductModel> getMockProductDetail(String productId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return const MarketProductModel(
      id: '1',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
      galleryImages: [
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1503342217505-b0a15ec515c7?q=80&w=500&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1576566588028-4147f3842f27?q=80&w=500&auto=format&fit=crop',
      ],
      title: 'Ankara Print Hoodie — Limited Edition',
      sellerName: 'AfroStyle KLA',
      sellerAvatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
      isVerifiedSeller: true,
      sellerRating: 4.8,
      sellerSales: 234,
      rating: 4.6,
      reviewCount: 147,
      category: 'Clothing',
      price: 'UGX 78,000',
      inStock: true,
      description:
          'Premium handcrafted Ankara print hoodie featuring authentic African patterns. Made with 100% organic cotton for maximum comfort and durability.',
      availableColors: ['Red', 'Blue', 'Green', 'Black'],
      availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
    );
  }

  @override
  Future<List<MarketProductModel>> getMockRelatedProducts(
    String productId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      MarketProductModel(
        id: '10',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        title: 'Dashiki Shirt',
        sellerName: 'Craft Studio UG',
        rating: 4.5,
        category: 'Clothing',
        price: 'UGX 65,000',
      ),
      MarketProductModel(
        id: '11',
        imageUrl:
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=500&auto=format&fit=crop',
        title: 'Masai Bracelet',
        sellerName: 'Heritage Jewels',
        rating: 4.7,
        category: 'Crafts',
        price: 'UGX 145,000',
      ),
      MarketProductModel(
        id: '12',
        imageUrl:
            'https://images.unsplash.com/photo-1588850561407-ed78c334e67a?q=80&w=500&auto=format&fit=crop',
        title: 'Kente Cap',
        sellerName: 'AfroStyle KLA',
        rating: 4.3,
        category: 'Clothing',
        price: 'UGX 38,000',
      ),
    ];
  }

  @override
  Future<List<CartItemModel>> getMockCartItems() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      CartItemModel(
        id: 'cart_1',
        productId: '1',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        title: 'Ankara Print Hoodie',
        sellerName: 'AfroStyle KLA',
        selectedColor: 'Red',
        selectedSize: 'XL',
        price: 'UGX 78,000',
        quantity: 1,
      ),
    ];
  }

  @override
  Future<List<DeliveryAddressModel>> getMockDeliveryAddresses() async {
    await Future.delayed(const Duration(milliseconds: 200));

    return const [
      DeliveryAddressModel(
        id: 'addr_1',
        label: 'Home',
        address: 'Buganda Rd, Kampala',
        isDefault: true,
      ),
      DeliveryAddressModel(
        id: 'addr_2',
        label: 'Work',
        address: 'Bea Town, Kampala',
      ),
    ];
  }
}
