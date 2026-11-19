class ProductVariantItem {
  final String size;
  final int quantity;
  final double price;

  const ProductVariantItem({
    required this.size,
    required this.quantity,
    required this.price,
  });

  ProductVariantItem copyWith({
    String? size,
    int? quantity,
    double? price,
  }) {
    return ProductVariantItem(
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

class ColorVariantModel {
  final String colorName;
  final String? hexColor;
  final List<ProductVariantItem> sizes;

  const ColorVariantModel({
    required this.colorName,
    this.hexColor,
    this.sizes = const [],
  });

  ColorVariantModel copyWith({
    String? colorName,
    String? hexColor,
    List<ProductVariantItem>? sizes,
  }) {
    return ColorVariantModel(
      colorName: colorName ?? this.colorName,
      hexColor: hexColor ?? this.hexColor,
      sizes: sizes ?? this.sizes,
    );
  }
}
