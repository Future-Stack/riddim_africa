import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riddimafrica/core/core.dart';

class ArtistVerificationBanner extends StatelessWidget {
  final VoidCallback onClose;

  const ArtistVerificationBanner({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundcolor,
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            IconPath.info,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Verify your seller account to build trust, unlock additional platform features, and strengthen your store on Riddim Africa.',
              style: AppTextStyle(context).mediumTextStyle(
                color: AppColors.white,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onClose,
            child: Icon(
              Icons.close,
              color: AppColors.primarytext.withValues(alpha: 0.6),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
