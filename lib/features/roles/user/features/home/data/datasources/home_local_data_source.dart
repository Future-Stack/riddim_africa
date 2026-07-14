import '../models/product_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ProductModel>> getMockProducts();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<ProductModel>> getMockProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return const [
      ProductModel(
        id: '1',
        imageUrl:
            'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?q=80&w=500&auto=format&fit=crop',
        title: 'Kente Drum Bag',
        subtitle: 'Craft Studio UG',
        rating: 4.9,
        categoryText: 'Artist Merch',
        price: 'UGX 45,000',
        isHot: true,
      ),
      ProductModel(
        id: '2',
        imageUrl:
            'https://images.unsplash.com/photo-1550581190-9c1c48d21d6c?q=80&w=500&auto=format&fit=crop',
        title: 'Ankara Sneakers',
        subtitle: 'Sole Africa',
        rating: 4.7,
        categoryText: 'Clothing',
        price: 'UGX 85,000',
      ),
      ProductModel(
        id: '3',
        imageUrl:
            'https://images.unsplash.com/photo-1578932750294-f5075e85f44a?q=80&w=500&auto=format&fit=crop',
        title: 'Tribal Mask Art',
        subtitle: 'Woodland Arts',
        rating: 4.8,
        categoryText: 'Art',
        price: 'UGX 120,000',
      ),
      ProductModel(
        id: '4',
        imageUrl:
            'https://images.unsplash.com/photo-1603484435887-39b036579fc9?q=80&w=500&auto=format&fit=crop',
        title: 'Beaded Necklace',
        subtitle: 'Heritage Jewels',
        rating: 4.5,
        categoryText: 'Crafts',
        price: 'UGX 25,000',
        isHot: true,
      ),
    ];
  }
}
