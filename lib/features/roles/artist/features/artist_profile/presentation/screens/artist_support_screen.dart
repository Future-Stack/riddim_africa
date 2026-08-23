import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_support_controller.dart';
import 'artist_live_chat_screen.dart';

class ArtistSupportScreen extends StatelessWidget {
  const ArtistSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistSupportController>()
        ? Get.find<ArtistSupportController>()
        : Get.put(ArtistSupportController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Support',
        showDivider: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Top 2 Action Cards ─────────────────────────────────────
              Row(
                children: [
                  // 1. Live Chat Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.to(() => const ArtistLiveChatScreen()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryappbrown,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF382111),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: const Color(0xFFD49B53),
                                size: 20.sp,
                              ),
                            ),
                            12.verticalSpace,
                            Text(
                              'Live Chat',
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            6.verticalSpace,
                            Text(
                              'Avg. 5 min response',
                              style: AppTextStyle(context).regularTextStyle(
                                fontSize: 11.sp,
                                color: AppColors.primarytext,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,

                  // 2. Email Support Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.sendEmail(
                        email: 'support@riddim.africa',
                        subject: 'Artist Support Inquiry - Riddim Africa',
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryappbrown,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF382111),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.email_outlined,
                                color: const Color(0xFFD49B53),
                                size: 20.sp,
                              ),
                            ),
                            12.verticalSpace,
                            Text(
                              'Email Support',
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            6.verticalSpace,
                            Text(
                              'support@riddim.africa',
                              style: AppTextStyle(context).regularTextStyle(
                                fontSize: 11.sp,
                                color: AppColors.primarytext,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              24.verticalSpace,

              // ─── Contact Support Box ─────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryappbrown,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Title
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                      child: Text(
                        'Contact Support',
                        style: AppTextStyle(context).boldTextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFFD49B53),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.white.withValues(alpha: 0.06),
                      height: 1,
                    ),

                    // Row 1: Phone
                    _buildContactItem(
                      context: context,
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: '+256 800 123 000',
                      onTap: () => controller.makePhoneCall('+256 800 123 000'),
                    ),
                    Divider(
                      color: AppColors.white.withValues(alpha: 0.06),
                      height: 1,
                    ),

                    // Row 2: Email
                    _buildContactItem(
                      context: context,
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: 'support@riddim.africa',
                      onTap: () => controller.sendEmail(
                        email: 'support@riddim.africa',
                        subject: 'Artist Support Inquiry',
                      ),
                    ),
                    Divider(
                      color: AppColors.white.withValues(alpha: 0.06),
                      height: 1,
                    ),

                    // Row 3: Office
                    _buildContactItem(
                      context: context,
                      icon: Icons.location_on_outlined,
                      label: 'Office',
                      value: 'Kampala, Uganda',
                      isLast: true,
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? BorderRadius.vertical(bottom: Radius.circular(16.r))
          : BorderRadius.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFD49B53),
              size: 20.sp,
            ),
            14.horizontalSpace,
            Text(
              label,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFD49B53),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: AppTextStyle(context).regularTextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
