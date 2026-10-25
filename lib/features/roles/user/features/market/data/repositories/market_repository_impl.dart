import 'dart:developer';
import '../../domain/entities/market_product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/entities/checkout_result_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../datasources/market_local_data_source.dart';
import '../datasources/market_remote_data_source.dart';
import '../models/delivery_address_model.dart';

class MarketRepositoryImpl implements MarketRepository {
  final MarketLocalDataSource localDataSource;
  final MarketRemoteDataSource remoteDataSource;

  MarketRepositoryImpl(
    this.localDataSource, {
    MarketRemoteDataSource? remoteDataSource,
  }) : remoteDataSource = remoteDataSource ?? MarketRemoteDataSourceImpl();

  @override
  Future<MarketProductEntity> getProductDetail(String productId) async {
    try {
      final remoteProduct = await remoteDataSource.getProductDetails(productId);
      return remoteProduct;
    } catch (e) {
      log('MarketRepositoryImpl.getProductDetail failed, falling back to mock: $e');
      return localDataSource.getMockProductDetail(productId);
    }
  }

  @override
  Future<List<MarketProductEntity>> getRelatedProducts(String productId) async {
    final models = await localDataSource.getMockRelatedProducts(productId);
    return models;
  }

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    try {
      final remoteItems = await remoteDataSource.getCart();
      if (remoteItems.isNotEmpty) {
        return remoteItems;
      }
      return remoteItems;
    } catch (e) {
      log('MarketRepositoryImpl.getCartItems failed, falling back to mock: $e');
      return await localDataSource.getMockCartItems();
    }
  }

  @override
  Future<bool> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  }) async {
    return remoteDataSource.addToCart(
      productId: productId,
      quantity: quantity,
      color: color,
      size: size,
    );
  }

  @override
  Future<List<DeliveryAddressEntity>> getDeliveryAddresses() async {
    try {
      final remoteAddresses = await remoteDataSource.getShippingAddresses();
      if (remoteAddresses.isNotEmpty) {
        return remoteAddresses;
      }
      return await localDataSource.getMockDeliveryAddresses();
    } catch (e) {
      log('MarketRepositoryImpl.getDeliveryAddresses failed, falling back to mock: $e');
      return await localDataSource.getMockDeliveryAddresses();
    }
  }

  @override
  Future<DeliveryAddressEntity> saveDeliveryAddress(
    DeliveryAddressEntity address,
  ) async {
    final model = DeliveryAddressModel(
      id: address.id,
      label: address.label,
      address: address.address,
      isDefault: address.isDefault,
      fullName: address.fullName,
      phoneNumber: address.phoneNumber,
      email: address.email,
      city: address.city,
      streetAddress: address.streetAddress,
      specialInstruction: address.specialInstruction,
      latitude: address.latitude,
      longitude: address.longitude,
    );
    return remoteDataSource.saveShippingAddress(model);
  }

  @override
  Future<DeliveryAddressEntity> updateDeliveryAddress(
    String id,
    DeliveryAddressEntity address,
  ) async {
    final model = DeliveryAddressModel(
      id: address.id,
      label: address.label,
      address: address.address,
      isDefault: address.isDefault,
      fullName: address.fullName,
      phoneNumber: address.phoneNumber,
      email: address.email,
      city: address.city,
      streetAddress: address.streetAddress,
      specialInstruction: address.specialInstruction,
      latitude: address.latitude,
      longitude: address.longitude,
    );
    return remoteDataSource.updateShippingAddress(id, model);
  }

  @override
  Future<CheckoutResultEntity> processCheckout({
    required String? shippingInfoId,
    required Map<String, dynamic> shippingDetails,
    required String paymentMethod,
    required String checkoutType,
    Map<String, dynamic>? directPurchase,
  }) async {
    return remoteDataSource.processCheckout(
      shippingInfoId: shippingInfoId,
      shippingDetails: shippingDetails,
      paymentMethod: paymentMethod,
      checkoutType: checkoutType,
      directPurchase: directPurchase,
    );
  }

  @override
  Future<List<MarketProductEntity>> getArtistProducts(
    String artistName,
  ) async {
    return localDataSource.getMockArtistProducts(artistName);
  }

  @override
  Future<List<MarketProductEntity>> getMarketProducts({
    int page = 1,
    int limit = 10,
    String? search,
    String? categoryId,
    String? collectionId,
    String? collectionTitle,
  }) async {
    try {
      final remoteProducts = await remoteDataSource.getProducts(
        page: page,
        limit: limit,
        search: search,
        categoryId: categoryId,
        collectionId: collectionId,
        collectionTitle: collectionTitle,
      );
      if (remoteProducts.isNotEmpty) {
        return remoteProducts;
      }
      return remoteProducts;
    } catch (e) {
      log('MarketRepositoryImpl.getMarketProducts failed, falling back to mock: $e');
      return localDataSource.getMockProducts();
    }
  }
}
