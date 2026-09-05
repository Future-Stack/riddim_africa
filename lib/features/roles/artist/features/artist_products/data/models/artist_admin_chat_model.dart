class ArtistChatMessageModel {
  final String id;
  final String text;
  final String time;
  final bool isFromAdmin;
  final String? senderAvatar;
  final String? attachmentUrl;

  const ArtistChatMessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isFromAdmin,
    this.senderAvatar,
    this.attachmentUrl,
  });

  static List<ArtistChatMessageModel> getInitialMessages() {
    return const [
      ArtistChatMessageModel(
        id: '1',
        text:
            "Hi Amara! We've reviewed your product sample submission for the Kente Cloth Set. Great quality! We'd like to proceed to the next stage.",
        time: '10:24 AM',
        isFromAdmin: true,
        senderAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      ),
      ArtistChatMessageModel(
        id: '2',
        text:
            'Please deliver your physical product sample to our Lagos office for inspection and professional photography. Our team will be available Mon–Sat, 9am–5pm.',
        time: '10:26 AM',
        isFromAdmin: true,
        senderAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      ),
      ArtistChatMessageModel(
        id: '3',
        text:
            "Once we receive it, we'll inspect the product, do a professional photoshoot, and publish it live on the marketplace. This usually takes 3–5 business days.",
        time: '10:26 AM',
        isFromAdmin: true,
        senderAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      ),
      ArtistChatMessageModel(
        id: '4',
        text:
            "Understood! I'll deliver the product to your office this week. Thank you!",
        time: '10:30 AM',
        isFromAdmin: false,
        senderAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      ),
    ];
  }
}
