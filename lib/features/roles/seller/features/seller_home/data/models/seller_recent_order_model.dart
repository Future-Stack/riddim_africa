import '../../domain/entities/seller_recent_order_entity.dart';

class SellerRecentOrderModel extends SellerRecentOrderEntity {
  const SellerRecentOrderModel({
    required super.id,
    required super.productName,
    required super.productImageUrl,
    required super.customerName,
    required super.date,
    required super.status,
    required super.price,
  });

  factory SellerRecentOrderModel.fromJson(Map<String, dynamic> json) {
    return SellerRecentOrderModel(
      id: json['id'] ?? '',
      productName: json['productName'] ?? '',
      productImageUrl: json['productImageUrl'] ?? '',
      customerName: json['customerName'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'customerName': customerName,
      'date': date,
      'status': status,
      'price': price,
    };
  }
}
