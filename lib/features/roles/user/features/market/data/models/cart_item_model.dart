import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.imageUrl,
    required super.title,
    required super.sellerName,
    super.selectedColor = '',
    super.selectedSize = '',
    required super.price,
    super.quantity = 1,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      sellerName: json['sellerName'] as String,
      selectedColor: json['selectedColor'] as String? ?? '',
      selectedSize: json['selectedSize'] as String? ?? '',
      price: json['price'] as String,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'imageUrl': imageUrl,
      'title': title,
      'sellerName': sellerName,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'price': price,
      'quantity': quantity,
    };
  }
}
