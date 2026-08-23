enum ArtistDocumentStatus { verified, pending, rejected }

class ArtistDocumentSideItem {
  final String title;
  final ArtistDocumentStatus status;
  final String? previewUrl;
  final String? localFilePath;

  const ArtistDocumentSideItem({
    required this.title,
    required this.status,
    this.previewUrl,
    this.localFilePath,
  });

  ArtistDocumentSideItem copyWith({
    String? title,
    ArtistDocumentStatus? status,
    String? previewUrl,
    String? localFilePath,
  }) {
    return ArtistDocumentSideItem(
      title: title ?? this.title,
      status: status ?? this.status,
      previewUrl: previewUrl ?? this.previewUrl,
      localFilePath: localFilePath ?? this.localFilePath,
    );
  }
}

class ArtistDocumentModel {
  final String id;
  final String title;
  final String icon;
  final List<ArtistDocumentSideItem> items;
  final String? description;

  const ArtistDocumentModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.items,
    this.description,
  });

  ArtistDocumentModel copyWith({
    String? id,
    String? title,
    String? icon,
    List<ArtistDocumentSideItem>? items,
    String? description,
  }) {
    return ArtistDocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      items: items ?? this.items,
      description: description ?? this.description,
    );
  }

  static List<ArtistDocumentModel> get mockDocuments => [
        const ArtistDocumentModel(
          id: 'national_id',
          title: 'National ID',
          icon: 'badge',
          description:
              'Your identity has been successfully verified by the Riddim Africa verification team.',
          items: [
            ArtistDocumentSideItem(
              title: 'Front Side',
              status: ArtistDocumentStatus.verified,
              previewUrl:
                  'https://images.unsplash.com/photo-1544717305-2782549b5136?w=600&auto=format&fit=crop&q=80',
            ),
            ArtistDocumentSideItem(
              title: 'Back Side',
              status: ArtistDocumentStatus.verified,
              previewUrl:
                  'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600&auto=format&fit=crop&q=80',
            ),
          ],
        ),
        const ArtistDocumentModel(
          id: 'passport',
          title: 'Passport',
          icon: 'passport',
          description:
              'Upload a clear scan of the biometric photo page of your international passport.',
          items: [
            ArtistDocumentSideItem(
              title: 'Photo Page',
              status: ArtistDocumentStatus.pending,
              previewUrl: null,
            ),
          ],
        ),
        const ArtistDocumentModel(
          id: 'driving_license',
          title: 'Driving License',
          icon: 'license',
          description:
              'Upload an official government issued driver license verifying your legal identity.',
          items: [
            ArtistDocumentSideItem(
              title: 'Photo Page',
              status: ArtistDocumentStatus.pending,
              previewUrl: null,
            ),
          ],
        ),
      ];
}
