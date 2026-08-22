import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riddimafrica/core/core.dart';
import '../../controllers/seller_chat_controller.dart';
import '../../data/models/seller_chat_message_model.dart';

class SellerLiveChatScreen extends StatelessWidget {
  const SellerLiveChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SellerChatController>()
        ? Get.find<SellerChatController>()
        : Get.put(SellerChatController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const GlobalAppBar(
        title: 'Live chat',
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat Timeline
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    // Date indicator
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22140A),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'TODAY, JUNE 12',
                          style: AppTextStyle(context).boldTextStyle(
                            fontSize: 10.sp,
                            color: AppColors.primarytext.withValues(alpha: 0.8),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,

                    // Messages List
                    Obx(
                      () => Column(
                        children: controller.messages.map((msg) {
                          return _buildMessageBubble(context, msg);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Input Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border(
                  top: BorderSide(
                    color: AppColors.white.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Pill-shaped Mint/Ice-White Text Input (Auto-expanding like Messenger)
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 46.h,
                        maxHeight: 120.h,
                      ),
                      padding: EdgeInsets.only(
                        left: 14.w,
                        right: 4.w,
                        top: 2.h,
                        bottom: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF6F6),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.messageInputController,
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: const Color(0xFF162525),
                                height: 1.3,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(
                                  fontSize: 13.5.sp,
                                  color: const Color(0xFF769392),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 4.w,
                                ),
                                isDense: true,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.sentiment_satisfied_alt_outlined,
                                color: const Color(0xFF2C7D79),
                                size: 22.sp,
                              ),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 6.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.horizontalSpace,

                  // Circular Teal Send Button
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: GestureDetector(
                      onTap: () => controller.sendMessage(),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2C7D79),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            IconPath.send,
                            width: 18.w,
                            height: 18.w,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
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

  Widget _buildMessageBubble(
      BuildContext context, SellerChatMessageModel message) {
    if (message.isFromAdmin) {
      return Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Avatar
            ClipOval(
              child: SizedBox(
                width: 32.w,
                height: 32.w,
                child: message.avatarUrl != null
                    ? CachedNetworkImage(
                        imageUrl: message.avatarUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          color: const Color(0xFF382111),
                          child: const Icon(
                            Icons.support_agent,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      )
                    : Container(
                        color: const Color(0xFF382111),
                        child: const Icon(
                          Icons.support_agent,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
              ),
            ),
            10.horizontalSpace,

            // Admin Bubble
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22140A),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        lineHeight: 18,
                      ),
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    message.time,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 10.sp,
                      color: AppColors.primarytext.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            30.horizontalSpace,
          ],
        ),
      );
    } else {
      // Seller message (right side)
      return Padding(
        padding: EdgeInsets.only(bottom: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            30.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E1A10),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      border: Border.all(
                        color: const Color(0xFFD49B53).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        lineHeight: 18,
                      ),
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    message.time,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 10.sp,
                      color: AppColors.primarytext.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,

            // Seller Avatar
            ClipOval(
              child: SizedBox(
                width: 32.w,
                height: 32.w,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFF382111),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
