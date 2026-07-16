import 'package:riddimafrica/core/utils/constants/enums.dart';

class OrderEntity {
  final String id;
  final String orderNumber;
  final String imageUrl;
  final String title;
  final String sellerName;
  final String price;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final OrderStatus status;
  final String statusLabel;
  final String expectedDelivery;
  final String estimatedDate;
  final DateTime orderDate;
  final String shippingAddress;
  final String paymentMethod;
  final bool isPaid;
  final String deliveryFee;
  final String totalPrice;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.imageUrl,
    required this.title,
    required this.sellerName,
    required this.price,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
    this.status = OrderStatus.processing,
    this.statusLabel = 'Processing',
    this.expectedDelivery = '3-5 Business Days',
    this.estimatedDate = '',
    required this.orderDate,
    this.shippingAddress = '',
    this.paymentMethod = '',
    this.isPaid = false,
    this.deliveryFee = 'UGX 0',
    this.totalPrice = '',
  });
}
