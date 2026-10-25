import '../models/product_model.dart';
import '../models/artist_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ProductModel>> getMockProducts();
  Future<List<ArtistModel>> getMockArtists();
  Future<List<ProductModel>> getMockTrendingProducts();
  Future<List<ArtistModel>> getMockFeaturedArtists();
  Future<List<ProductModel>> getMockFeaturedProducts();
  Future<List<ProductModel>> getMockArtistMerchandise();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<ProductModel>> getMockProducts() async {
    final trending = await getMockTrendingProducts();
    final featured = await getMockFeaturedProducts();
    final merch = await getMockArtistMerchandise();
    return [...trending, ...featured, ...merch];
  }

  @override
  Future<List<ArtistModel>> getMockArtists() async {
    return getMockFeaturedArtists();
  }

  @override
  Future<List<ProductModel>> getMockTrendingProducts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      ProductModel(
        id: 'trend_1',
        imageUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=500&auto=format&fit=crop',
        title: 'Afrobeats Vinyl',
        subtitle: 'Heritage Sound',
        rating: 5.0,
        categoryText: 'Vinyl',
        price: 'UGX 120,000',
        isHot: true,
      ),
      ProductModel(
        id: 'trend_2',
        imageUrl:
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=500&auto=format&fit=crop',
        title: 'Masai Bracelet',
        subtitle: 'Heritage Jewels',
        rating: 4.8,
        categoryText: 'Crafts',
        price: 'UGX 22,000',
      ),
      ProductModel(
        id: 'trend_3',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        title: 'Dashiki Shirt',
        subtitle: 'AfroStyle KLA',
        rating: 4.6,
        categoryText: 'Clothing',
        price: 'UGX 65,000',
      ),
    ];
  }

  @override
  Future<List<ArtistModel>> getMockFeaturedArtists() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      ArtistModel(
        id: 'a1',
        name: 'Bobi Wine',
        imageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=300&auto=format&fit=crop',
        genre: 'Afropop / Reggae',
        followers: '2.4M',
      ),
      ArtistModel(
        id: 'a2',
        name: 'Eddy Kenzo',
        imageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=300&auto=format&fit=crop',
        genre: 'Afrobeats',
        followers: '1.8M',
      ),
      ArtistModel(
        id: 'a3',
        name: 'Spice Diana',
        imageUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300&auto=format&fit=crop',
        genre: 'Afropop',
        followers: '980K',
      ),
      ArtistModel(
        id: 'a4',
        name: 'Fik Fameica',
        imageUrl:
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=300&auto=format&fit=crop',
        genre: 'Rap / Afrobeats',
        followers: '1.2M',
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getMockFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      ProductModel(
        id: 'feat_1',
        imageUrl:
            'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=80&w=500&auto=format&fit=crop',
        title: 'Mounted Track Sky',
        subtitle: 'Digital Space',
        rating: 4.8,
        categoryText: 'Digital Product',
        price: 'UGX 5,000',
      ),
      ProductModel(
        id: 'feat_2',
        imageUrl:
            'https://images.unsplash.com/photo-1556821840-3a63f95609a7?q=80&w=500&auto=format&fit=crop',
        title: 'Ankara Print Hoodie',
        subtitle: 'AfroStyle KLA',
        rating: 4.7,
        categoryText: 'Clothing',
        price: 'UGX 78,000',
        isHot: true,
      ),
      ProductModel(
        id: 'feat_3',
        imageUrl:
            'https://images.unsplash.com/photo-1603561591411-07134e71a2a9?q=80&w=500&auto=format&fit=crop',
        title: 'Beaded Bracelet',
        subtitle: 'Zuri Jewels',
        rating: 4.9,
        categoryText: 'Art',
        price: 'UGX 32,000',
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getMockArtistMerchandise() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      ProductModel(
        id: 'merch_1',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500&auto=format&fit=crop',
        title: 'Presidential T-Shirt',
        subtitle: 'Bobi Wine Merch',
        rating: 4.9,
        categoryText: 'Artist Merch',
        price: 'UGX 55,000',
        artistName: 'Bobi Wine',
        artistAvatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100&auto=format&fit=crop',
        isVerifiedArtist: true,
      ),
      ProductModel(
        id: 'merch_2',
        imageUrl:
            'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?q=80&w=500&auto=format&fit=crop',
        title: 'Eddy Kenzo Cap',
        subtitle: 'Eddy Kenzo Merch',
        rating: 4.7,
        categoryText: 'Artist Merch',
        price: 'UGX 35,000',
        artistName: 'Eddy Kenzo',
        artistAvatarUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=100&auto=format&fit=crop',
        isVerifiedArtist: true,
      ),
      ProductModel(
        id: 'merch_3',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=500&auto=format&fit=crop',
        title: 'Spice Diana Bag',
        subtitle: 'Spice Diana Merch',
        rating: 4.8,
        categoryText: 'Artist Merch',
        price: 'UGX 48,000',
        artistName: 'Spice Diana',
        artistAvatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=100&auto=format&fit=crop',
        isVerifiedArtist: true,
      ),
    ];
  }
}
