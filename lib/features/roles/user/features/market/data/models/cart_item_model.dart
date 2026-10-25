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
    super.rawPrice,
    super.totalItemPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    // Seller name extraction
    String sellerName = '';
    if (json['seller'] is Map) {
      sellerName = (json['seller']['fullName'] ?? '').toString();
    } else if (json['sellerName'] != null) {
      sellerName = json['sellerName'].toString();
    }

    // Price extraction and formatting
    final num? rawPrice = json['price'] is num
        ? json['price'] as num
        : num.tryParse(json['price']?.toString() ?? '');
    final num? totalItemPrice = json['totalItemPrice'] is num
        ? json['totalItemPrice'] as num
        : num.tryParse(json['totalItemPrice']?.toString() ?? '');

    String formattedPrice = '';
    if (rawPrice != null) {
      formattedPrice = 'UGX ${_formatPriceNumber(rawPrice.toInt())}';
    } else {
      formattedPrice = (json['price'] ?? '').toString();
    }

    return CartItemModel(
      id: (json['cartItemId'] ?? json['id'] ?? '').toString(),
      productId: (json['productId'] ?? '').toString(),
      imageUrl: (json['image'] ?? json['imageUrl'] ?? '').toString(),
      title: (json['name'] ?? json['title'] ?? '').toString(),
      sellerName: sellerName,
      selectedColor: (json['color'] ?? json['selectedColor'] ?? '').toString(),
      selectedSize: (json['size'] ?? json['selectedSize'] ?? '').toString(),
      price: formattedPrice,
      quantity: json['quantity'] as int? ?? 1,
      rawPrice: rawPrice,
      totalItemPrice: totalItemPrice,
    );
  }

  static String _formatPriceNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItemId': id,
      'productId': productId,
      'image': imageUrl,
      'name': title,
      'sellerName': sellerName,
      'color': selectedColor,
      'size': selectedSize,
      'price': rawPrice ?? price,
      'quantity': quantity,
    };
  }
}
