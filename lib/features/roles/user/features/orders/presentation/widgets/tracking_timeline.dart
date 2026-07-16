import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';

class TrackingTimeline extends StatelessWidget {
  final List<dynamic> events;

  const TrackingTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(events.length, (index) {
        final event = events[index];
        final isLast = index == events.length - 1;
        return _buildTimelineItem(
          context: context,
          event: event,
          isLast: isLast,
        );
      }),
    );
  }

  Widget _buildTimelineItem({
    required BuildContext context,
    required dynamic event,
    required bool isLast,
  }) {
    final isCompleted = event.isCompleted as bool;
    final isCurrent = event.isCurrent as bool;
    final title = event.title as String;
    final description = event.description as String;

    Color circleColor;
    Color lineColor;
    Color titleColor;
    Color descColor;

    if (isCompleted) {
      circleColor = const Color(0xFF377A7D);
      lineColor = const Color(0xFF377A7D);
      titleColor = AppColors.white;
      descColor = AppColors.primarytext;
    } else if (isCurrent) {
      circleColor = const Color(0xFF377A7D);
      lineColor = AppColors.primaryappbrownsecond;
      titleColor = AppColors.white;
      descColor = AppColors.primarytext;
    } else {
      circleColor = AppColors.primaryappbrownsecond;
      lineColor = AppColors.primaryappbrownsecond;
      titleColor = AppColors.primarytext.withValues(alpha: 0.6);
      descColor = AppColors.primarytext.withValues(alpha: 0.4);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator (circle and line)
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent
                        ? circleColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted || isCurrent
                          ? Colors.transparent
                          : AppColors.primaryappbrownsecond,
                      width: 2,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : isCurrent
                          ? Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          : const Icon(
                              Iconsax.clock,
                              size: 12,
                              color: AppColors.primarytext,
                            ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Event Description
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyle(context).boldTextStyle(
                          color: titleColor,
                          fontSize: AppTextStyle.md,
                        ),
                      ),
                      if (isCurrent) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC84C3E), // red/orange badge
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'CURRENT',
                            style: AppTextStyle(context).boldTextStyle(
                              color: AppColors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyle(context).regularTextStyle(
                      color: descColor,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
