import '../../domain/entities/product_entity.dart';
import '../../domain/entities/artist_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl(this.localDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final productModels = await localDataSource.getMockProducts();
    // In Dart, since ProductModel extends ProductEntity, we can just return it.
    // If it didn't, we would map the models to entities here.
    return productModels;
  }

  @override
  Future<List<ArtistEntity>> getArtists() async {
    final artistModels = await localDataSource.getMockArtists();
    return artistModels;
  }

  @override
  Future<List<ProductEntity>> getTrendingProducts() async {
    return localDataSource.getMockTrendingProducts();
  }

  @override
  Future<List<ArtistEntity>> getFeaturedArtists() async {
    return localDataSource.getMockFeaturedArtists();
  }

  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    return localDataSource.getMockFeaturedProducts();
  }

  @override
  Future<List<ProductEntity>> getArtistMerchandise() async {
    return localDataSource.getMockArtistMerchandise();
  }
}
