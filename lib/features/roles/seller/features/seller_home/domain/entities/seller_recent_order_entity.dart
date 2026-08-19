class SellerRecentOrderEntity {
  final String id;
  final String productName;
  final String productImageUrl;
  final String customerName;
  final String date;
  final String status;
  final double price;

  const SellerRecentOrderEntity({
    required this.id,
    required this.productName,
    required this.productImageUrl,
    required this.customerName,
    required this.date,
    required this.status,
    required this.price,
  });
}
