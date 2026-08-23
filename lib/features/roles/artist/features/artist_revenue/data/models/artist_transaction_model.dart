import '../../domain/entities/artist_transaction_entity.dart';

class ArtistTransactionModel extends ArtistTransactionEntity {
  const ArtistTransactionModel({
    required super.id,
    required super.productTitle,
    required super.date,
    required super.status,
    required super.grossRevenue,
    required super.commission,
    required super.netAmount,
    required super.formattedAmount,
    required super.paymentMethod,
    required super.orderDeliveredDate,
    required super.paymentReceivedDate,
    required super.iconLetter,
  });

  factory ArtistTransactionModel.fromJson(Map<String, dynamic> json) {
    return ArtistTransactionModel(
      id: json['id'] ?? '',
      productTitle: json['product_title'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] == 'inProgress'
          ? ArtistTransactionStatus.inProgress
          : ArtistTransactionStatus.settled,
      grossRevenue: (json['gross_revenue'] as num?)?.toDouble() ?? 0.0,
      commission: (json['commission'] as num?)?.toDouble() ?? 0.0,
      netAmount: (json['net_amount'] as num?)?.toDouble() ?? 0.0,
      formattedAmount: json['formatted_amount'] ?? '',
      paymentMethod: json['payment_method'] ?? 'Airtel Money',
      orderDeliveredDate: json['order_delivered_date'] ?? '',
      paymentReceivedDate: json['payment_received_date'] ?? '',
      iconLetter: json['icon_letter'] ?? 'P',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_title': productTitle,
      'date': date,
      'status': status == ArtistTransactionStatus.inProgress
          ? 'inProgress'
          : 'settled',
      'gross_revenue': grossRevenue,
      'commission': commission,
      'net_amount': netAmount,
      'formatted_amount': formattedAmount,
      'payment_method': paymentMethod,
      'order_delivered_date': orderDeliveredDate,
      'payment_received_date': paymentReceivedDate,
      'icon_letter': iconLetter,
    };
  }

  static List<ArtistTransactionModel> getInitialTransactions() {
    return [
      const ArtistTransactionModel(
        id: '# SP ID: 64546',
        productTitle: 'Presidential T-Shirt',
        date: 'Jun 12, 2:14 PM',
        status: ArtistTransactionStatus.settled,
        grossRevenue: 200000.0,
        commission: 35000.0,
        netAmount: 165000.0,
        formattedAmount: '+UGX 165,000',
        paymentMethod: 'Airtel Money',
        orderDeliveredDate: 'Jun 8, 2026 · 2:14 PM',
        paymentReceivedDate: 'Jun 12, 2026 · 2:14 PM',
        iconLetter: 'P',
      ),
      const ArtistTransactionModel(
        id: '# SP ID: 64547',
        productTitle: 'Vintage Denim Jacket',
        date: 'Jun 12, 3:45 PM',
        status: ArtistTransactionStatus.settled,
        grossRevenue: 290000.0,
        commission: 50000.0,
        netAmount: 240000.0,
        formattedAmount: '+UGX 240,000',
        paymentMethod: 'MTN Mobile Money',
        orderDeliveredDate: 'Jun 8, 2026 · 3:45 PM',
        paymentReceivedDate: 'Jun 12, 2026 · 3:45 PM',
        iconLetter: 'V',
      ),
      const ArtistTransactionModel(
        id: 'PRD ID - 5454',
        productTitle: 'Gen - Z Hoodie',
        date: 'Order completed - 02/02/26',
        status: ArtistTransactionStatus.inProgress,
        grossRevenue: 200000.0,
        commission: 35000.0,
        netAmount: 165000.0,
        formattedAmount: 'UGX 165,000',
        paymentMethod: 'Airtel Money',
        orderDeliveredDate: 'PRD ID: 5454',
        paymentReceivedDate: '6th May, 2026',
        iconLetter: 'G',
      ),
      const ArtistTransactionModel(
        id: 'PRD ID - 5454',
        productTitle: 'Gen - Z Hoodie',
        date: 'Order completed - 02/02/26',
        status: ArtistTransactionStatus.inProgress,
        grossRevenue: 200000.0,
        commission: 35000.0,
        netAmount: 165000.0,
        formattedAmount: 'UGX 165,000',
        paymentMethod: 'MTN Mobile Money',
        orderDeliveredDate: 'PRD ID: 5454',
        paymentReceivedDate: '6th May, 2026',
        iconLetter: 'G',
      ),
      const ArtistTransactionModel(
        id: '# SP ID: 64548',
        productTitle: 'Handcrafted Leather Wallet',
        date: 'Jun 12, 4:30 PM',
        status: ArtistTransactionStatus.settled,
        grossRevenue: 100000.0,
        commission: 15000.0,
        netAmount: 85000.0,
        formattedAmount: '+UGX 85,000',
        paymentMethod: 'Airtel Money',
        orderDeliveredDate: 'Jun 8, 2026 · 4:30 PM',
        paymentReceivedDate: 'Jun 12, 2026 · 4:30 PM',
        iconLetter: 'H',
      ),
    ];
  }
}
