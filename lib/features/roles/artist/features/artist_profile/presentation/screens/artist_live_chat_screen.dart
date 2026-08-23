import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_live_chat_controller.dart';
import '../../data/models/artist_chat_message_model.dart';

class ArtistLiveChatScreen extends StatelessWidget {
  const ArtistLiveChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ArtistLiveChatController>()
        ? Get.find<ArtistLiveChatController>()
        : Get.put(ArtistLiveChatController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: GlobalAppBar(
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Riddim Support',
              style: AppTextStyle(context).boldTextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34C759),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'Online • Avg. 5 min response',
                  style: AppTextStyle(context).regularTextStyle(
                    color: AppColors.primarytext,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        showDivider: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ─── Messages List ──────────────────────────────────────────
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return _buildMessageBubble(context, message);
                  },
                ),
              ),
            ),

            // ─── Agent Typing Indicator ─────────────────────────────────
            Obx(() {
              if (!controller.isAgentTyping.value) return const SizedBox.shrink();
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Support agent is typing...',
                      style: TextStyle(
                        color: AppColors.primarytext,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            }),

            // ─── Input Bar ──────────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryappbrown,
                border: Border(
                  top: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textfieldcolor,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: TextField(
                        controller: controller.textController,
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: AppTextStyle(context).regularTextStyle(
                            fontSize: 14.sp,
                            color: AppColors.white.withValues(alpha: 0.4),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 12.h,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => controller.sendMessage(),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ArtistChatMessage message) {
    final isMe = message.isMe;
    final timeStr = DateFormat('hh:mm a').format(message.timestamp);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.76,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.secondary
              : AppColors.primaryappbrown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isMe ? 16.r : 4.r),
            bottomRight: Radius.circular(isMe ? 4.r : 16.r),
          ),
          border: Border.all(
            color: isMe
                ? Colors.transparent
                : AppColors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: AppTextStyle(context).regularTextStyle(
                fontSize: 13.sp,
                color: Colors.white,
                lineHeight: 18,
              ),
            ),
            4.verticalSpace,
            Text(
              timeStr,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
