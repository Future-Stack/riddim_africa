import 'package:flutter/material.dart';
import 'package:riddimafrica/core/core.dart';
import '../../data/models/review_timeline_step_model.dart';

class ReviewTimelineWidget extends StatelessWidget {
  final List<ReviewTimelineStepModel> steps;
  final VoidCallback onRespondToAdmin;

  const ReviewTimelineWidget({
    super.key,
    required this.steps,
    required this.onRespondToAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PROGRESS',
          style: AppTextStyle(context).boldTextStyle(
            color: AppColors.primarytext,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: steps.length,
          itemBuilder: (context, index) {
            final step = steps[index];
            final isLast = index == steps.length - 1;

            return _buildTimelineItem(context, step, isLast);
          },
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    ReviewTimelineStepModel step,
    bool isLast,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Node & Vertical Line
          Column(
            children: [
              _buildStepIcon(step),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: step.status == ReviewStepStatus.completed
                        ? const Color(0xFFBB483D)
                        : AppColors.white.withValues(alpha: 0.1),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTextStyle(context).boldTextStyle(
                      color: step.status == ReviewStepStatus.pending
                          ? AppColors.white.withValues(alpha: 0.5)
                          : AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: AppTextStyle(context).regularTextStyle(
                      color: step.status == ReviewStepStatus.pending
                          ? AppColors.primarytext.withValues(alpha: 0.4)
                          : AppColors.primarytext,
                      fontSize: 12,
                    ),
                  ),
                  if (step.timestamp != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      step.timestamp!,
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext.withValues(alpha: 0.6),
                        fontSize: 10,
                      ),
                    ),
                  ],
                  if (step.actionButtonText != null) ...[
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: onRespondToAdmin,
                      child: Text(
                        step.actionButtonText!,
                        style: AppTextStyle(context).boldTextStyle(
                          color: const Color(0xFFFF7043),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIcon(ReviewTimelineStepModel step) {
    switch (step.status) {
      case ReviewStepStatus.completed:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFBB483D),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 14,
          ),
        );
      case ReviewStepStatus.active:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFBB483D).withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFBB483D),
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFBB483D),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case ReviewStepStatus.pending:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.15),
            ),
          ),
          child: Center(
            child: Text(
              '${step.stepNumber}',
              style: const TextStyle(
                color: AppColors.primarytext,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }
}
