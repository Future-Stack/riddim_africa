class ArtistFaqModel {
  final String id;
  final String question;
  final String answer;

  const ArtistFaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  static List<ArtistFaqModel> get mockFaqs => const [
        ArtistFaqModel(
          id: 'faq-1',
          question: 'How do I become a seller?',
          answer:
              'To become a seller on Riddim Africa, complete your profile details, upload your identity verification documents, and register your business details. Once approved, you can start listing products immediately.',
        ),
        ArtistFaqModel(
          id: 'faq-2',
          question: 'What can I sell?',
          answer:
              'You can sell authentic African art, merchandise, handcrafted apparel, fashion accessories, music media, cultural artifacts, and authorized digital creative goods.',
        ),
        ArtistFaqModel(
          id: 'faq-3',
          question: 'How do I list a product?',
          answer:
              'Navigate to the Products tab, tap "+ Submit Product", fill in product specifications, upload high quality images, set your price and stock inventory, then submit for review.',
        ),
        ArtistFaqModel(
          id: 'faq-4',
          question:
              'What\'s the difference between a physical and a digital product?',
          answer:
              'Physical products require shipping and delivery inspection before payout, whereas digital products (music tracks, presets, artwork files) are delivered instantly via digital download.',
        ),
        ArtistFaqModel(
          id: 'faq-5',
          question: 'How does selling a photo or digital product work?',
          answer:
              'When you upload a digital product, customers can purchase high-resolution licensed copies directly. Payout is processed upon completed customer transaction.',
        ),
        ArtistFaqModel(
          id: 'faq-6',
          question: 'What proof of ownership do I need to upload?',
          answer:
              'You may be asked to upload business registration certificates, copyright proof, trademark certificates, or artisan guild membership letters.',
        ),
        ArtistFaqModel(
          id: 'faq-7',
          question: 'How and when do I get paid?',
          answer:
              'Earnings are credited to your seller wallet once the buyer confirms delivery. You can request payouts directly to Mobile Money (MTN / Airtel) or bank account at any time.',
        ),
        ArtistFaqModel(
          id: 'faq-8',
          question: 'What does Riddim Africa charge?',
          answer:
              'Riddim Africa takes a small commission of 5%-10% per transaction to cover marketplace maintenance, secure payments processing, and buyer protection.',
        ),
        ArtistFaqModel(
          id: 'faq-9',
          question: 'How do I get verified?',
          answer:
              'Go to Profile > Verification Badge, upload your National ID/Passport and business license. The admin team reviews verification requests within 24-48 business hours.',
        ),
        ArtistFaqModel(
          id: 'faq-10',
          question: 'Can I sell as both a seller and an artist?',
          answer:
              'Yes! You can switch roles seamlessly or maintain both merchant merchandise and verified artist audio/visual catalogs under the same unified ecosystem.',
        ),
        ArtistFaqModel(
          id: 'faq-11',
          question: 'What can\'t I sell?',
          answer:
              'Counterfeit items, unauthorized copyrighted material, hazardous goods, weapons, prescription pharmaceuticals, and unverified replica goods are strictly prohibited.',
        ),
        ArtistFaqModel(
          id: 'faq-12',
          question: 'How do I get support?',
          answer:
              'You can initiate a Live Chat directly from the Support tab for fast 5-minute average response times, or email us at support@riddim.africa.',
        ),
      ];
}
