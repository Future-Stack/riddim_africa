import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class RatingBreakdownWidget extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final Map<int, int> distribution;

  const RatingBreakdownWidget({
    super.key,
    required this.rating,
    required this.reviewsCount,
    required this.distribution,
  });

  @override
  Widget build(BuildContext context) {
    final int total = distribution.values.fold(0, (sum, count) => sum + count);
    final int safeTotal = total > 0 ? total : 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side: Rating score & stars
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFB300),
                    size: 16,
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(
                '$reviewsCount reviews',
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.primarytext,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),

          // Right side: 5-star distribution bars
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((star) {
                final count = distribution[star] ?? 0;
                final double progress = count / safeTotal;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                        child: Text(
                          '$star',
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 5,
                            backgroundColor: AppColors.white.withValues(alpha: 0.1),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFFFB300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
