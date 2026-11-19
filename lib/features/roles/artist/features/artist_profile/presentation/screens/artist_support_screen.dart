import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/artist_support_controller.dart';
import '../widgets/artist_faq_item_card.dart';
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top 2 Action Cards (Live Chat & Email Support)
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.to(() => const ArtistLiveChatScreen()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22140A),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF382111),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat_bubble_outline_rounded,
                                color: const Color(0xFFD49B53),
                                size: 18.sp,
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'Live Chat',
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              'Avg. 5 min response',
                              style: AppTextStyle(context).regularTextStyle(
                                fontSize: 10.sp,
                                color: AppColors.primarytext,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.sendEmail(
                        email: 'support@riddim.africa',
                        subject: 'Riddim Africa - Artist Support Inquiry',
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22140A),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF382111),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.email_outlined,
                                color: const Color(0xFFD49B53),
                                size: 18.sp,
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'Email Support',
                              style: AppTextStyle(context).boldTextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              'support@riddim.africa',
                              style: AppTextStyle(context).regularTextStyle(
                                fontSize: 10.sp,
                                color: AppColors.primarytext,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              24.verticalSpace,

              // Contact Support Section
              Text(
                'Contact Support',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFFD49B53),
                ),
              ),
              12.verticalSpace,

              _buildContactRow(
                context: context,
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: '+256 800 123 000',
                onTap: () => controller.makePhoneCall('+256 800 123 000'),
              ),
              10.verticalSpace,

              _buildContactRow(
                context: context,
                icon: Icons.email_outlined,
                label: 'Email',
                value: 'support@riddim.africa',
                onTap: () => controller.sendEmail(
                  email: 'support@riddim.africa',
                  subject: 'Artist Support Request',
                ),
              ),
              10.verticalSpace,

              _buildContactRow(
                context: context,
                icon: Icons.location_on_outlined,
                label: 'Office',
                value: 'Kampala, Uganda',
              ),
              24.verticalSpace,

              // Frequently Asked Questions Section
              Text(
                'Frequently Asked Questions',
                style: AppTextStyle(context).boldTextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFFD49B53),
                ),
              ),
              12.verticalSpace,

              Obx(
                () => Column(
                  children: controller.faqs.map((faq) {
                    final isExpanded = controller.isFaqExpanded(faq.id);
                    return ArtistFaqItemCard(
                      faq: faq,
                      isExpanded: isExpanded,
                      onTap: () => controller.toggleFaq(faq.id),
                    );
                  }).toList(),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF22140A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.06),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFD49B53),
              size: 18.sp,
            ),
            12.horizontalSpace,
            Text(
              label,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 13.sp,
                color: AppColors.primarytext,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: AppTextStyle(context).mediumTextStyle(
                  fontSize: 13.sp,
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
