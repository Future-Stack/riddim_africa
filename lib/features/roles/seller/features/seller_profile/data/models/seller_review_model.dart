class SellerReviewModel {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String date;
  final String comment;

  const SellerReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.date,
    required this.comment,
  });

  static List<SellerReviewModel> get mockReviews => const [
        SellerReviewModel(
          id: 'rev-01',
          userName: 'Liam Torres',
          userAvatar:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&auto=format&fit=crop&q=80',
          rating: 5.0,
          date: 'Jun 12, 2025',
          comment:
              'The leather wallet exceeded my expectations. Stylish and durable, perfect for everyday use.',
        ),
        SellerReviewModel(
          id: 'rev-02',
          userName: 'Liam Torres',
          userAvatar:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&auto=format&fit=crop&q=80',
          rating: 5.0,
          date: 'Jun 12, 2025',
          comment:
              'The leather wallet exceeded my expectations. Stylish and durable, perfect for everyday use.',
        ),
        SellerReviewModel(
          id: 'rev-03',
          userName: 'Amara Okafor',
          userAvatar:
              'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&auto=format&fit=crop&q=80',
          rating: 5.0,
          date: 'Jun 10, 2025',
          comment:
              'Fast delivery and exquisite fabric texture. Will definitely order again from this seller!',
        ),
        SellerReviewModel(
          id: 'rev-04',
          userName: 'Kofi Mensah',
          userAvatar:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&auto=format&fit=crop&q=80',
          rating: 4.0,
          date: 'Jun 05, 2025',
          comment:
              'Great craftmanship! The stitching is very neat and authentic.',
        ),
      ];
}

class SellerRatingBreakdown {
  final int star;
  final double percentage; // e.g. 0.78 for 78%
  final String label;

  const SellerRatingBreakdown({
    required this.star,
    required this.percentage,
    required this.label,
  });

  static List<SellerRatingBreakdown> get mockBreakdown => const [
        SellerRatingBreakdown(star: 5, percentage: 0.78, label: '78%'),
        SellerRatingBreakdown(star: 4, percentage: 0.14, label: '14%'),
        SellerRatingBreakdown(star: 3, percentage: 0.05, label: '5%'),
        SellerRatingBreakdown(star: 2, percentage: 0.02, label: '2%'),
        SellerRatingBreakdown(star: 1, percentage: 0.01, label: '1%'),
      ];
}
