import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/radio_controller.dart';
import '../../domain/entities/chat_message_entity.dart';
import 'radio_player_view.dart';

class RadioChatView extends StatefulWidget {
  const RadioChatView({super.key});

  @override
  State<RadioChatView> createState() => _RadioChatViewState();
}

class _RadioChatViewState extends State<RadioChatView> {
  final RxBool showPinned = true.obs;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RadioController>();

    return Column(
      children: [
        // ─── Scrollable Body ──────────────────────────────────────────
        Expanded(
          child: ListView(
            controller: controller.scrollController,
            padding: EdgeInsets.zero,
            children: [
              // 1. Live Radio Player at the top
              const RadioPlayerView(),

              // 2. Chat Header Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Live Chat',
                      style: AppTextStyle(
                        context,
                      ).boldTextStyle(color: AppColors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),

              // 3. Pinned Message Banner
              Obx(() {
                if (!showPinned.value) return const SizedBox.shrink();

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A2114),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.onboardingbutton.withValues(alpha: 0.3),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.push_pin,
                        color: AppColors.onboardingbutton,
                        size: 18,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Pinned',
                                  style: AppTextStyle(context).boldTextStyle(
                                    color: AppColors.onboardingbutton,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '@djkolade',
                                  style: AppTextStyle(context).regularTextStyle(
                                    color: AppColors.primarytext,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Request line is open! Drop your song requests here ..',
                              style: AppTextStyle(context).mediumTextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => showPinned.value = false,
                        child: const Icon(
                          Icons.close,
                          color: AppColors.primarytext,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              // 4. Chat Messages List
              Obx(() {
                if (controller.isChatLoading.value &&
                    controller.chatMessages.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(
                        color: AppColors.bordercolor,
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    children: controller.chatMessages
                        .map((message) => _ChatBubble(message: message))
                        .toList(),
                  ),
                );
              }),
            ],
          ),
        ),

        // ─── Sticky Input Row at the bottom ───────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            border: Border(
              top: BorderSide(color: AppColors.primaryappbrownsecond, width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF2F4),
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          style: GoogleFonts.outfit(
                            color: AppColors.black,
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            hintText: 'Type a message...',
                            hintStyle: GoogleFonts.outfit(
                              color: Colors.grey.shade600,
                              fontSize: 16.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onSubmitted: (_) => controller.sendMessage(),
                        ),
                      ),
                      const Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: controller.sendMessage,
                child: Container(
                  height: 52.h,
                  width: 52.h,
                  decoration: const BoxDecoration(
                    color: AppColors.bordercolor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.send, color: AppColors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final ChatMessageEntity message;

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('HH:mm').format(message.timestamp);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(message.senderAvatar),
            backgroundColor: AppColors.primaryappbrownsecond,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message.senderName,
                      style: AppTextStyle(context).boldTextStyle(
                        color: message.isPresenter
                            ? AppColors.onboardingbutton
                            : AppColors.white,
                        fontSize: 15,
                      ),
                    ),
                    if (message.isPresenter) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: AppColors.onboardingbutton,
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.mic,
                              color: AppColors.onboardingbutton,
                              size: 10,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'PRESENTER',
                              style: GoogleFonts.outfit(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onboardingbutton,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4.w),
                      const Icon(
                        Icons.push_pin,
                        color: AppColors.onboardingbutton,
                        size: 12,
                      ),
                    ],
                    const Spacer(),
                    Text(
                      timeStr,
                      style: AppTextStyle(context).regularTextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  message.message,
                  style: AppTextStyle(context).regularTextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
