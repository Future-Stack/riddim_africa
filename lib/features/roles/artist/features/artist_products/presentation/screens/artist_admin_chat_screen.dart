import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riddimafrica/core/core.dart';
import '../controllers/artist_admin_chat_controller.dart';
import '../../data/models/artist_admin_chat_model.dart';

class ArtistAdminChatScreen extends GetView<ArtistAdminChatController> {
  const ArtistAdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.isRegistered<ArtistAdminChatController>()
        ? Get.find<ArtistAdminChatController>()
        : Get.put(ArtistAdminChatController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.appbardivider,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            // Admin Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primarytext, width: 1),
                image: DecorationImage(
                  image: NetworkImage(c.adminAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Name & Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.adminName,
                  style: AppTextStyle(context).boldTextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: AppTextStyle(context).regularTextStyle(
                        color: const Color(0xFF4CAF50),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            const Divider(height: 1, color: Color(0x1AFFFFFF)),

            // Date Separator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'TODAY, JUNE 12',
                style: AppTextStyle(context).boldTextStyle(
                  color: AppColors.primarytext.withValues(alpha: 0.6),
                  fontSize: 10,
                  letterSpacing: 1.0,
                ),
              ),
            ),

            // Messages List (reversed so newest messages are at the bottom like Messenger)
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: c.scrollController,
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: c.messages.length,
                  itemBuilder: (context, index) {
                    final msg = c.messages[c.messages.length - 1 - index];
                    return _buildMessageBubble(context, msg);
                  },
                ),
              ),
            ),

            // Message Input Field
            _buildInputBar(context, c),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ArtistChatMessageModel msg) {
    if (msg.isFromAdmin) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admin Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                msg.senderAvatar ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 32,
                  height: 32,
                  color: Colors.white10,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Bubble
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C1A0D),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
                    ),
                    child: Text(
                      msg.text,
                      style: AppTextStyle(context).regularTextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        lineHeight: 19,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg.time,
                    style: AppTextStyle(context).regularTextStyle(
                      color: AppColors.primarytext.withValues(alpha: 0.6),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Artist message (right aligned)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF382111),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      border: Border.all(color: const Color(0xFFBB483D).withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      msg.text,
                      style: AppTextStyle(context).regularTextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        lineHeight: 19,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        msg.time,
                        style: AppTextStyle(context).regularTextStyle(
                          color: AppColors.primarytext.withValues(alpha: 0.6),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all, color: Color(0xFF00B4D8), size: 14),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // User Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                msg.senderAvatar ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 28,
                  height: 28,
                  color: Colors.white10,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  static const List<String> _popularEmojis = [
    '😀', '😂', '😍', '🥰', '😎', '😊', '😉', '🥳',
    '👍', '🙌', '👏', '🔥', '✨', '🌟', '🎉', '❤️',
    '🤔', '😮', '😢', '😡', '😱', '🤫', '💯', '🙏',
  ];

  void _showEmojiPopup(BuildContext context, TextEditingController textCtrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1005),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.bordercolor.withValues(alpha: 0.5),
                width: 1.w,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Emoji',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemCount: _popularEmojis.length,
                  itemBuilder: (context, index) {
                    final emoji = _popularEmojis[index];
                    return GestureDetector(
                      onTap: () {
                        final text = textCtrl.text;
                        final selection = textCtrl.selection;
                        if (selection.isValid) {
                          final newText = text.replaceRange(
                            selection.start,
                            selection.end,
                            emoji,
                          );
                          textCtrl.text = newText;
                          textCtrl.selection = TextSelection.collapsed(
                            offset: selection.start + emoji.length,
                          );
                        } else {
                          textCtrl.text = text + emoji;
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E190B),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(emoji, style: TextStyle(fontSize: 20.sp)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputBar(BuildContext context, ArtistAdminChatController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        border: Border(
          top: BorderSide(
            color: AppColors.primaryappbrownsecond,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2F4),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.bordercolor,
                    width: 1.5,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: c.messageInputController,
                        style: GoogleFonts.outfit(
                          color: AppColors.black,
                          fontSize: 15.sp,
                        ),
                        minLines: 1,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Type a message...',
                          hintStyle: GoogleFonts.outfit(
                            color: Colors.grey.shade600,
                            fontSize: 15.sp,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        onSubmitted: (_) => c.sendMessage(),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => _showEmojiPopup(context, c.messageInputController),
                      child: SvgPicture.asset(
                        IconPath.kid,
                        width: 22.h,
                        height: 22.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () => c.sendMessage(),
              child: Container(
                height: 44.h,
                width: 44.h,
                decoration: const BoxDecoration(
                  color: AppColors.bordercolor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    IconPath.send,
                    width: 18.h,
                    height: 18.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
