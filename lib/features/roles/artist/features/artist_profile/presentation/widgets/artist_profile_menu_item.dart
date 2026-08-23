import 'package:flutter/material.dart';
import 'package:riddimafrica/core/utils/constants/colors.dart';
import 'package:riddimafrica/core/common/styles/global_text_style.dart';

class ArtistProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const ArtistProfileMenuItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Circular Icon Container
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyle(context).mediumTextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  // Chevron Arrow
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.primarytext.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppColors.primarytext.withValues(alpha: 0.08),
            ),
          ),
      ],
    );
  }
}
