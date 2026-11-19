enum SellerTransactionStatus {
  settled,
  inProgress,
}

extension SellerTransactionStatusExt on SellerTransactionStatus {
  String get label {
    switch (this) {
      case SellerTransactionStatus.settled:
        return '• Payment Received';
      case SellerTransactionStatus.inProgress:
        return '• Payout in Progress';
    }
  }
}

class SellerTransactionModel {
  final String id;
  final String productTitle;
  final String date;
  final SellerTransactionStatus status;
  final String grossRevenue;
  final String commission;
  final String netAmount;
  final String formattedAmount;
  final String paymentMethod;
  final String orderDelivered;
  final String paymentReceived;
  final String iconLetter;

  const SellerTransactionModel({
    required this.id,
    required this.productTitle,
    required this.date,
    required this.status,
    required this.grossRevenue,
    required this.commission,
    required this.netAmount,
    required this.formattedAmount,
    required this.paymentMethod,
    required this.orderDelivered,
    required this.paymentReceived,
    required this.iconLetter,
  });

  static List<SellerTransactionModel> getInitialTransactions() {
    return [
      const SellerTransactionModel(
        id: '# SP ID: 64546',
        productTitle: 'Presidential T-Shirt',
        date: 'Jun 12, 2:14 PM',
        status: SellerTransactionStatus.settled,
        grossRevenue: 'UGX 200,000',
        commission: '-UGX 35,000',
        netAmount: 'UGX 165,000',
        formattedAmount: '+UGX 165,0',
        paymentMethod: 'Airtel Money',
        orderDelivered: 'Jun 11, 2024 - 2:14 PM',
        paymentReceived: 'Jun 12, 2024 - 3:14 PM',
        iconLetter: 'T',
      ),
      const SellerTransactionModel(
        id: '# SP ID: 64547',
        productTitle: 'Vintage Denim Jacket',
        date: 'Jun 12, 3:45 PM',
        status: SellerTransactionStatus.settled,
        grossRevenue: 'UGX 290,000',
        commission: '-UGX 50,000',
        netAmount: 'UGX 240,000',
        formattedAmount: '+UGX 240,0',
        paymentMethod: 'MTN Mobile Money',
        orderDelivered: 'Jun 11, 2024 - 1:00 PM',
        paymentReceived: 'Jun 12, 2024 - 3:45 PM',
        iconLetter: 'V',
      ),
      const SellerTransactionModel(
        id: '# SP ID: 64548',
        productTitle: 'Handcrafted Leather Wallet',
        date: 'Jun 12, 4:30 PM',
        status: SellerTransactionStatus.settled,
        grossRevenue: 'UGX 100,000',
        commission: '-UGX 15,000',
        netAmount: 'UGX 85,000',
        formattedAmount: '+UGX 85,00',
        paymentMethod: 'Airtel Money',
        orderDelivered: 'Jun 11, 2024 - 11:30 AM',
        paymentReceived: 'Jun 12, 2024 - 4:30 PM',
        iconLetter: 'H',
      ),
      const SellerTransactionModel(
        id: '#PRD ID - 5454',
        productTitle: 'Gen - Z Hoodie',
        date: 'Order completed - 12/2026',
        status: SellerTransactionStatus.inProgress,
        grossRevenue: 'UGX 230,000',
        commission: '-UGX 35,000',
        netAmount: 'UGX 195,000',
        formattedAmount: 'UGX 195,000',
        paymentMethod: 'Airtel Money',
        orderDelivered: '11th May, 2026',
        paymentReceived: 'Pending confirmation',
        iconLetter: 'G',
      ),
      const SellerTransactionModel(
        id: '#PRD ID - 5455',
        productTitle: 'Gen - Z Hoodie',
        date: 'Order completed - 12/2026',
        status: SellerTransactionStatus.inProgress,
        grossRevenue: 'UGX 230,000',
        commission: '-UGX 35,000',
        netAmount: 'UGX 195,000',
        formattedAmount: 'UGX 195,000',
        paymentMethod: 'MTN Mobile Money',
        orderDelivered: '11th May, 2026',
        paymentReceived: 'Pending confirmation',
        iconLetter: 'G',
      ),
      const SellerTransactionModel(
        id: '#PRD ID - 5456',
        productTitle: 'Gen - Z Hoodie',
        date: 'Order completed - 12/2026',
        status: SellerTransactionStatus.inProgress,
        grossRevenue: 'UGX 230,000',
        commission: '-UGX 35,000',
        netAmount: 'UGX 195,000',
        formattedAmount: 'UGX 195,000',
        paymentMethod: 'Bank Transfer',
        orderDelivered: '11th May, 2026',
        paymentReceived: 'Pending confirmation',
        iconLetter: 'G',
      ),
    ];
  }
}
