class CartItemEntity {
  final String id;
  final String productId;
  final String imageUrl;
  final String title;
  final String sellerName;
  final String selectedColor;
  final String selectedSize;
  final String price;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.sellerName,
    this.selectedColor = '',
    this.selectedSize = '',
    required this.price,
    this.quantity = 1,
  });

  CartItemEntity copyWith({
    String? id,
    String? productId,
    String? imageUrl,
    String? title,
    String? sellerName,
    String? selectedColor,
    String? selectedSize,
    String? price,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      sellerName: sellerName ?? this.sellerName,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
