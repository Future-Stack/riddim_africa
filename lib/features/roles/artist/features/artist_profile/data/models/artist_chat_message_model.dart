class ArtistChatMessageModel {
  final String id;
  final String text;
  final String time;
  final bool isFromAdmin;
  final String? avatarUrl;

  const ArtistChatMessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isFromAdmin,
    this.avatarUrl,
  });

  static List<ArtistChatMessageModel> get initialChatMessages => const [
        ArtistChatMessageModel(
          id: 'msg-1',
          text:
              "Hi Amara! We've reviewed your product sample submission for the Kente Cloth Set. Great quality! We'd like to proceed to the next stage.",
          time: '10:24 AM',
          isFromAdmin: true,
          avatarUrl:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
        ),
        ArtistChatMessageModel(
          id: 'msg-2',
          text:
              "Please deliver your physical product sample to our Lagos office for inspection and professional photography. Our team will be available Mon–Sat, 9am–5pm.",
          time: '10:26 AM',
          isFromAdmin: true,
          avatarUrl:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
        ),
        ArtistChatMessageModel(
          id: 'msg-3',
          text:
              "Once we receive it, we'll inspect the product, do a professional photoshoot, and publish it live on the marketplace. This usually takes 3–5 business days.",
          time: '10:26 AM',
          isFromAdmin: true,
          avatarUrl:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
        ),
        ArtistChatMessageModel(
          id: 'msg-4',
          text:
              "Understood! I'll deliver the product to your office this week. Thank you!",
          time: '10:26 AM',
          isFromAdmin: false,
          avatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
        ),
      ];
}
