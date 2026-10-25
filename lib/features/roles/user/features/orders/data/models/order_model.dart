import 'package:riddimafrica/core/utils/constants/enums.dart';
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
    final productData = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : null;

    final title = productData?['name']?.toString() ??
        json['title']?.toString() ??
        'Product';

    String imageUrl = '';
    if (productData != null &&
        productData['files'] is List &&
        (productData['files'] as List).isNotEmpty) {
      imageUrl = productData['files'][0]?.toString() ?? '';
    } else {
      imageUrl = json['imageUrl']?.toString() ?? '';
    }

    final paymentData = json['payment'] is Map<String, dynamic>
        ? json['payment'] as Map<String, dynamic>
        : null;

    num? paymentAmount;
    if (paymentData != null && paymentData['amount'] != null) {
      paymentAmount = num.tryParse(paymentData['amount'].toString());
    } else if (json['price'] != null && json['price'] is num) {
      paymentAmount = json['price'] as num;
    }

    String formatUgx(num val) {
      return 'UGX ${val.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }

    final String formattedPrice = paymentAmount != null
        ? formatUgx(paymentAmount)
        : (json['price']?.toString() ?? 'UGX 0');

    final String formattedTotal = paymentAmount != null
        ? formatUgx(paymentAmount)
        : (json['totalPrice']?.toString() ?? formattedPrice);

    final rawStatus = (json['status']?.toString() ?? 'PROCESSING').toUpperCase();
    OrderStatus orderStatus;
    String defaultStatusLabel;

    switch (rawStatus) {
      case 'DELIVERED':
        orderStatus = OrderStatus.delivered;
        defaultStatusLabel = 'Delivered';
        break;
      case 'CANCELLED':
      case 'CANCELED':
        orderStatus = OrderStatus.cancelled;
        defaultStatusLabel = 'Cancelled';
        break;
      case 'SHIPPED':
        orderStatus = OrderStatus.shipped;
        defaultStatusLabel = 'Shipped';
        break;
      case 'PROCESSING':
      case 'ACTIVE':
      default:
        orderStatus = OrderStatus.processing;
        defaultStatusLabel = 'Processing';
        break;
    }

    final String statusLabel = json['statusLabel'] as String? ?? defaultStatusLabel;

    DateTime date = DateTime.now();
    if (json['createdAt'] != null) {
      date = DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now();
    } else if (json['orderDate'] != null) {
      date = DateTime.tryParse(json['orderDate'].toString()) ?? DateTime.now();
    }

    final orderTimelineStatus = json['orderTimelineStatus']?.toString();
    final bool isPaid = orderTimelineStatus == 'PAYMENT_CONFIRMED' ||
        (json['isPaid'] as bool? ?? false);

    final int qty = json['quantity'] is int
        ? json['quantity'] as int
        : (int.tryParse(json['quantity']?.toString() ?? '') ?? 1);

    return OrderModel(
      id: json['orderId']?.toString() ?? json['id']?.toString() ?? '',
      orderNumber: json['showOrderId']?.toString() ?? json['orderNumber']?.toString() ?? '',
      imageUrl: imageUrl,
      title: title,
      sellerName: json['sellerName']?.toString() ?? 'Seller',
      price: formattedPrice,
      quantity: qty,
      selectedColor: json['color']?.toString() ?? json['selectedColor']?.toString(),
      selectedSize: json['size']?.toString() ?? json['selectedSize']?.toString(),
      status: orderStatus,
      statusLabel: statusLabel,
      expectedDelivery: json['expectedDelivery']?.toString() ?? '3-5 Business Days',
      estimatedDate: json['estimatedDate']?.toString() ?? '',
      orderDate: date,
      shippingAddress: json['shippingAddress']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? 'Mobile Money',
      isPaid: isPaid,
      deliveryFee: json['deliveryFee']?.toString() ?? 'UGX 0',
      totalPrice: formattedTotal,
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
