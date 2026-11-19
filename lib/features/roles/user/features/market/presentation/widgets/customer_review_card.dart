import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';

class CustomerReviewCard extends StatelessWidget {
  final String name;
  final String timeAgo;
  final String avatarUrl;
  final int rating;
  final String comment;

  const CustomerReviewCard({
    super.key,
    required this.name,
    required this.timeAgo,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryappbrown,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryappbrownsecond,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: AppTextStyle(
                            context,
                          ).boldTextStyle(color: AppColors.white, fontSize: 14),
                        ),
                        Text(
                          timeAgo,
                          style: AppTextStyle(context).regularTextStyle(
                            color: AppColors.primarytext,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        final isFilled = index < rating;
                        return Icon(
                          isFilled ? Icons.star : Icons.star_border,
                          color: AppColors.onboardingbutton,
                          size: 14,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          Text(
            comment,
            textAlign: TextAlign.start,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle(context).regularTextStyle(
              color: AppColors.onboardingtext.withValues(alpha: 0.9),
              fontSize: 13,
              lineHeight: 18,
            ),
          ),
        ],
      ),
    );
  }
}
