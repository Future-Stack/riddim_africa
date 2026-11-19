enum ArtistOrderStatus {
  newOrder,
  processing,
  pending,
  delivered,
  cancelled,
}

extension ArtistOrderStatusExtension on ArtistOrderStatus {
  String get label {
    switch (this) {
      case ArtistOrderStatus.newOrder:
        return '• New Order';
      case ArtistOrderStatus.processing:
        return '• Processing';
      case ArtistOrderStatus.pending:
        return '• Pending';
      case ArtistOrderStatus.delivered:
        return '• Delivered';
      case ArtistOrderStatus.cancelled:
        return '• Cancelled';
    }
  }
}

class ArtistOrderModel {
  final String id;
  final String productCode;
  final String productTitle;
  final String customerName;
  final String price;
  final int quantity;
  final ArtistOrderStatus status;
  final String orderTime;
  final String paymentMethod;
  final String productImage;
  final String shippingAddress;
  final String revenueAmount;
  final String? cancellationReason;
  final String? cancellationDate;
  final List<String> buyerEvidenceImages;

  const ArtistOrderModel({
    required this.id,
    required this.productCode,
    required this.productTitle,
    required this.customerName,
    required this.price,
    this.quantity = 1,
    required this.status,
    required this.orderTime,
    required this.paymentMethod,
    required this.productImage,
    this.shippingAddress = '14 Oluwole Ave, Ikeja, Lagos',
    this.revenueAmount = 'UGX 12,500',
    this.cancellationReason,
    this.cancellationDate,
    this.buyerEvidenceImages = const [],
  });

  static List<ArtistOrderModel> getInitialOrders() {
    return [
      // Active Orders
      const ArtistOrderModel(
        id: 'ORD-2024-00182',
        productCode: 'PRD-2024-00182',
        productTitle: 'Kente Fabric Roll (6 yards)',
        customerName: 'Chinwe Adeyemi',
        price: 'UGX 18,000',
        quantity: 1,
        status: ArtistOrderStatus.newOrder,
        orderTime: '11 Jun 2024, 08:30 AM',
        paymentMethod: 'Paid via Mobile Money',
        productImage:
            'https://images.unsplash.com/photo-1590736969955-71cc94801759?w=300',
        shippingAddress: '14 Oluwole Ave, Ikeja, Lagos',
        revenueAmount: 'UGX 12,500',
      ),
      const ArtistOrderModel(
        id: 'ORD-2024-00180',
        productCode: 'PRD-2024-00180',
        productTitle: 'Adire Beaded Necklace',
        customerName: 'Fatima Mohammed',
        price: 'UGX 6,700',
        quantity: 1,
        status: ArtistOrderStatus.processing,
        orderTime: '10 Jun 2024, 02:15 PM',
        paymentMethod: 'Paid via Card',
        productImage:
            'https://images.unsplash.com/photo-1611591475819-79730e70f2d1?w=300',
        shippingAddress: '14 Oluwole Ave, Ikeja, Lagos',
        revenueAmount: 'UGX 5,200',
      ),
      const ArtistOrderModel(
        id: 'ORD-2024-00179',
        productCode: 'PRD-2024-00179',
        productTitle: 'Ankara Wrap Dress',
        customerName: 'Kofi Bello',
        price: 'UGX 4,200',
        quantity: 1,
        status: ArtistOrderStatus.pending,
        orderTime: '09 Jun 2024, 11:45 AM',
        paymentMethod: 'Paid via Mobile Money',
        productImage:
            'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=300',
        shippingAddress: '14 Oluwole Ave, Ikeja, Lagos',
        revenueAmount: 'UGX 3,400',
      ),

      // Completed Orders
      const ArtistOrderModel(
        id: 'ORD-2024-00182',
        productCode: 'PRD-2024-00182',
        productTitle: 'Kente Fabric Roll (6 yards)',
        customerName: 'Chinwe Adeyemi',
        price: 'UGX 18,000',
        quantity: 1,
        status: ArtistOrderStatus.delivered,
        orderTime: '05 Jun 2024, 09:00 AM',
        paymentMethod: 'MTN Money',
        productImage:
            'https://images.unsplash.com/photo-1590736969955-71cc94801759?w=300',
        shippingAddress: '14 Oluwole Ave, Ikeja, Lagos',
        revenueAmount: 'UGX 12,500',
      ),
      const ArtistOrderModel(
        id: 'ORD-2024-00180',
        productCode: 'PRD-2024-00180',
        productTitle: 'Adire Beaded Necklace',
        customerName: 'Fatima Mohammed',
        price: 'UGX 6,700',
        quantity: 1,
        status: ArtistOrderStatus.delivered,
        orderTime: '04 Jun 2024, 04:30 PM',
        paymentMethod: 'Card Payment',
        productImage:
            'https://images.unsplash.com/photo-1611591475819-79730e70f2d1?w=300',
        shippingAddress: '14 Oluwole Ave, Ikeja, Lagos',
        revenueAmount: 'UGX 5,200',
      ),

      // Cancelled Orders
      const ArtistOrderModel(
        id: 'ORD-2024-00182',
        productCode: 'PRD-2024-00182',
        productTitle: 'Kente Fabric Roll (6 yards)',
        customerName: 'Chinwe Adeyemi',
        price: 'UGX 18,000',
        quantity: 1,
        status: ArtistOrderStatus.cancelled,
        orderTime: '12 Jun 2024, 10:14 AM',
        paymentMethod: 'Paid via Mobile Money',
        productImage:
            'https://images.unsplash.com/photo-1590736969955-71cc94801759?w=300',
        shippingAddress: '14 Oluwole Ave, Ikeja, Lagos',
        revenueAmount: 'UGX 0',
        cancellationReason:
            'Product doesn\'t match my expectations. The colour shown in the listing photo was different from what I received.',
        cancellationDate: 'Wed, June 12, 2024 • 10:14 AM',
        buyerEvidenceImages: [
          'https://images.unsplash.com/photo-1590736969955-71cc94801759?w=300',
          'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=300',
        ],
      ),
    ];
  }
}
