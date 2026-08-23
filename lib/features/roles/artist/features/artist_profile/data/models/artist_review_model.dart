import 'package:flutter/material.dart';

class ArtistReviewModel {
  final String id;
  final String userName;
  final String? userAvatar;
  final String initial;
  final Color avatarColor;
  final double rating;
  final String date;
  final String comment;

  const ArtistReviewModel({
    required this.id,
    required this.userName,
    this.userAvatar,
    required this.initial,
    this.avatarColor = const Color(0xFFE5A93C),
    required this.rating,
    required this.date,
    required this.comment,
  });

  static List<ArtistReviewModel> get mockReviews => const [
        ArtistReviewModel(
          id: 'rev-01',
          userName: 'Liam Torres',
          initial: 'L',
          avatarColor: Color(0xFFE5A93C),
          rating: 5.0,
          date: 'Jun 12, 2025',
          comment:
              'The leather wallet exceeded my expectations. Stylish and durable, perfect for everyday use.',
        ),
        ArtistReviewModel(
          id: 'rev-02',
          userName: 'Kelly Oka',
          initial: 'K',
          avatarColor: Color(0xFFE5A93C),
          rating: 5.0,
          date: 'Jun 12, 2025',
          comment:
              'The leather wallet exceeded my expectations. Stylish and durable, perfect for everyday use.',
        ),
        ArtistReviewModel(
          id: 'rev-03',
          userName: 'Amara Okafor',
          initial: 'A',
          avatarColor: Color(0xFFD49B53),
          rating: 5.0,
          date: 'Jun 10, 2025',
          comment:
              'Exceptional sound quality and authentic acoustic presence in every track. Truly mesmerizing!',
        ),
        ArtistReviewModel(
          id: 'rev-04',
          userName: 'Marcus Sterling',
          initial: 'M',
          avatarColor: Color(0xFFC7987A),
          rating: 4.8,
          date: 'Jun 08, 2025',
          comment:
              'Amazing production value and fast turnarounds for collaborative sessions.',
        ),
      ];
}

class ArtistRatingBreakdown {
  final int star;
  final double percentage; // e.g. 0.78 for 78%
  final String label;

  const ArtistRatingBreakdown({
    required this.star,
    required this.percentage,
    required this.label,
  });

  static List<ArtistRatingBreakdown> get mockBreakdown => const [
        ArtistRatingBreakdown(star: 5, percentage: 0.78, label: '78%'),
        ArtistRatingBreakdown(star: 4, percentage: 0.14, label: '14%'),
        ArtistRatingBreakdown(star: 3, percentage: 0.05, label: '5%'),
        ArtistRatingBreakdown(star: 2, percentage: 0.02, label: '2%'),
        ArtistRatingBreakdown(star: 1, percentage: 0.01, label: '1%'),
      ];
}
