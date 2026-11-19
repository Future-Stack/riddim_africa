import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riddimafrica/core/core.dart';

class RadioUserActionPopup extends StatelessWidget {
  final String username;
  final VoidCallback? onPin;
  final VoidCallback? onDelete;
  final VoidCallback? onMute15Min;
  final VoidCallback? onMute1Hour;
  final VoidCallback? onMutePermanently;
  final VoidCallback? onBan;

  const RadioUserActionPopup({
    super.key,
    required this.username,
    this.onPin,
    this.onDelete,
    this.onMute15Min,
    this.onMute1Hour,
    this.onMutePermanently,
    this.onBan,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1005),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildItem(
                context: context,
                icon: Icons.push_pin_outlined,
                iconColor: AppColors.onboardingbutton,
                text: 'Pin message',
                textColor: AppColors.onboardingbutton,
                onTap: () {
                  Navigator.of(context).pop();
                  onPin?.call();
                },
              ),
              _buildItem(
                context: context,
                icon: Icons.delete_outline,
                iconColor: AppColors.error,
                text: 'Delete message',
                textColor: AppColors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete?.call();
                },
              ),
              const Divider(color: Color(0xFF2E190B), height: 1, thickness: 1),
              _buildItem(
                context: context,
                icon: Icons.volume_off_outlined,
                iconColor: AppColors.onboardingbutton,
                text: 'Mute 15 minutes',
                textColor: AppColors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onMute15Min?.call();
                },
              ),
              _buildItem(
                context: context,
                icon: Icons.volume_off_outlined,
                iconColor: AppColors.onboardingbutton,
                text: 'Mute 1 hour',
                textColor: AppColors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onMute1Hour?.call();
                },
              ),
              _buildItem(
                context: context,
                icon: Icons.volume_off_outlined,
                iconColor: AppColors.onboardingbutton,
                text: 'Mute permanently',
                textColor: AppColors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onMutePermanently?.call();
                },
              ),
              const Divider(color: Color(0xFF2E190B), height: 1, thickness: 1),
              _buildItem(
                context: context,
                icon: Icons.block_outlined,
                iconColor: AppColors.onboardingbutton,
                text: 'Ban from chat',
                textColor: AppColors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onBan?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String text,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20.r),
              SizedBox(width: 16.w),
              Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
