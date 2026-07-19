import '../entities/product_entity.dart';
import '../entities/artist_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts();
  Future<List<ArtistEntity>> getArtists();
  Future<List<ProductEntity>> getTrendingProducts();
  Future<List<ArtistEntity>> getFeaturedArtists();
  Future<List<ProductEntity>> getFeaturedProducts();
  Future<List<ProductEntity>> getArtistMerchandise();
}
