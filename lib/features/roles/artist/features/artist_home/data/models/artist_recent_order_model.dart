import '../../domain/entities/artist_recent_order_entity.dart';

class ArtistRecentOrderModel extends ArtistRecentOrderEntity {
  const ArtistRecentOrderModel({
    required super.id,
    required super.productName,
    required super.productImageUrl,
    required super.customerName,
    required super.date,
    required super.status,
    required super.price,
  });

  factory ArtistRecentOrderModel.fromJson(Map<String, dynamic> json) {
    return ArtistRecentOrderModel(
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
