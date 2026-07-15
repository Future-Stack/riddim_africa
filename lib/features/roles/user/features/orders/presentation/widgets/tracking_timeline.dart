import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riddimafrica/core/core.dart';

class TrackingTimeline extends StatelessWidget {
  final List<dynamic> events;

  const TrackingTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    final date = event.date as String;

    Color lineColor;
    Color textColor;

    if (isCompleted) {
      lineColor = AppColors.success;
      textColor = AppColors.white;
    } else if (isCurrent) {
      lineColor = AppColors.onboardingbutton;
      textColor = AppColors.onboardingbutton;
    } else {
      lineColor = AppColors.primaryappbrownsecond;
      textColor = AppColors.primarytext;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: isCurrent ? 24 : 20,
                  height: isCurrent ? 24 : 20,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.success
                        : isCurrent
                            ? AppColors.onboardingbutton
                            : AppColors.primaryappbrownsecond,
                    shape: BoxShape.circle,
                    border: isCurrent
                        ? Border.all(color: AppColors.onboardingbutton, width: 3)
                        : null,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : isCurrent
                          ? const Icon(Iconsax.location,
                              size: 12, color: Colors.black)
                          : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: lineColor.withValues(alpha: 0.3),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle(context).semiBoldTextStyle(
                      color: textColor,
                      fontSize: AppTextStyle.md,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.textDisabled(context),
                      fontSize: AppTextStyle.xs,
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
