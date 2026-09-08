import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.imageUrl,
    required super.title,
    required super.sellerName,
    required super.price,
    super.quantity = 1,
    super.selectedColor,
    super.selectedSize,
    super.status,
    super.statusLabel,
    super.expectedDelivery,
    super.estimatedDate,
    required super.orderDate,
    super.shippingAddress,
    super.paymentMethod,
    super.isPaid,
    super.deliveryFee,
    super.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      sellerName: json['sellerName'] as String,
      price: json['price'] as String,
      quantity: json['quantity'] as int? ?? 1,
      selectedColor: json['selectedColor'] as String?,
      selectedSize: json['selectedSize'] as String?,
      statusLabel: json['statusLabel'] as String? ?? 'Processing',
      expectedDelivery: json['expectedDelivery'] as String? ?? '3-5 Business Days',
      estimatedDate: json['estimatedDate'] as String? ?? '',
      orderDate: DateTime.parse(json['orderDate'] as String),
      shippingAddress: json['shippingAddress'] as String? ?? '',
      paymentMethod: json['paymentMethod'] as String? ?? '',
      isPaid: json['isPaid'] as bool? ?? false,
      deliveryFee: json['deliveryFee'] as String? ?? 'UGX 0',
      totalPrice: json['totalPrice'] as String? ?? json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'imageUrl': imageUrl,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'quantity': quantity,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'statusLabel': statusLabel,
      'expectedDelivery': expectedDelivery,
      'estimatedDate': estimatedDate,
      'orderDate': orderDate.toIso8601String(),
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'deliveryFee': deliveryFee,
      'totalPrice': totalPrice,
    };
  }

  OrderModel copyWith({
    String? id,
    String? orderNumber,
    String? imageUrl,
    String? title,
    String? sellerName,
    String? price,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
    String? statusLabel,
    String? expectedDelivery,
    String? estimatedDate,
    DateTime? orderDate,
    String? shippingAddress,
    String? paymentMethod,
    bool? isPaid,
    String? deliveryFee,
    String? totalPrice,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      sellerName: sellerName ?? this.sellerName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      statusLabel: statusLabel ?? this.statusLabel,
      expectedDelivery: expectedDelivery ?? this.expectedDelivery,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      orderDate: orderDate ?? this.orderDate,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
