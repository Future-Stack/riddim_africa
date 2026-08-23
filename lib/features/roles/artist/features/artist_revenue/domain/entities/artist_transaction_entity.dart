enum ArtistTransactionStatus {
  settled,
  inProgress,
}

extension ArtistTransactionStatusExt on ArtistTransactionStatus {
  String get label {
    switch (this) {
      case ArtistTransactionStatus.settled:
        return 'Payment Received';
      case ArtistTransactionStatus.inProgress:
        return 'Payout in Progress';
    }
  }
}

class ArtistTransactionEntity {
  final String id;
  final String productTitle;
  final String date;
  final ArtistTransactionStatus status;
  final double grossRevenue;
  final double commission;
  final double netAmount;
  final String formattedAmount;
  final String paymentMethod;
  final String orderDeliveredDate;
  final String paymentReceivedDate;
  final String iconLetter;

  const ArtistTransactionEntity({
    required this.id,
    required this.productTitle,
    required this.date,
    required this.status,
    required this.grossRevenue,
    required this.commission,
    required this.netAmount,
    required this.formattedAmount,
    required this.paymentMethod,
    required this.orderDeliveredDate,
    required this.paymentReceivedDate,
    required this.iconLetter,
  });
}
