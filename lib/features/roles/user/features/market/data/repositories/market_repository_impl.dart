import 'dart:developer';
import '../../domain/entities/market_product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/delivery_address_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../datasources/market_local_data_source.dart';
import '../datasources/market_remote_data_source.dart';

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
