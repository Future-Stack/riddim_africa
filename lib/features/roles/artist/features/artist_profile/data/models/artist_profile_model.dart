class ArtistProfileModel {
  final String name;
  final String email;
  final String phone;
  final String city;
  final String country;
  final String state;
  final String avatarUrl;
  final bool isVerified;
  final String productsCount;
  final String soldCount;
  final String ratings;
  final String storeName;
  final String businessType;
  final String regNumber;
  final String businessAddress;
  final String website;
  final String businessDescription;

  const ArtistProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.country,
    required this.state,
    required this.avatarUrl,
    this.isVerified = true,
    required this.productsCount,
    required this.soldCount,
    required this.ratings,
    this.storeName = 'Afro Merch Store',
    this.businessType = 'Individual / Sole Proprietor',
    this.regNumber = 'R12399',
    this.businessAddress = 'Plot 14, Kampala Road, Central Business District',
    this.website = 'https://yourbusiness.com',
    this.businessDescription =
        'Authentic African apparel, handcrafted accessories, and premium cultural fashion directly from African artisans.',
  });

  static ArtistProfileModel get mockArtist => const ArtistProfileModel(
        name: 'Elishin Nakato',
        email: 'aisha.nakato@gmail.com',
        phone: '+256 700 123 456',
        city: 'Kampala',
        country: 'Uganda',
        state: 'Central Region',
        avatarUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=80',
        isVerified: true,
        productsCount: '1.2 k',
        soldCount: '80',
        ratings: '4.8',
        storeName: 'Afro Merch Store',
        businessType: '',
        regNumber: '',
        businessAddress: '',
        website: 'https://yourbusiness.com',
        businessDescription: '',
      );
}
