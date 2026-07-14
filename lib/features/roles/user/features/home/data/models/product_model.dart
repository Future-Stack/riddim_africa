import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.imageUrl,
    required super.title,
    required super.subtitle,
    required super.rating,
    required super.categoryText,
    required super.price,
    super.isHot = false,
  });

  // Example fromJson
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      rating: (json['rating'] as num).toDouble(),
      categoryText: json['categoryText'] as String,
      price: json['price'] as String,
      isHot: json['isHot'] as bool? ?? false,
    );
  }

  // Example toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'categoryText': categoryText,
      'price': price,
      'isHot': isHot,
    };
  }
}
