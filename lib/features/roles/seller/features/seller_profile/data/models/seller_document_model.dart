enum DocumentStatus { verified, pending, rejected }

class DocumentSideItem {
  final String title;
  final DocumentStatus status;
  final String? previewUrl;

  const DocumentSideItem({
    required this.title,
    required this.status,
    this.previewUrl,
  });
}

class SellerDocumentModel {
  final String id;
  final String title;
  final String icon;
  final List<DocumentSideItem> items;

  const SellerDocumentModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.items,
  });

  static List<SellerDocumentModel> get mockDocuments => [
        const SellerDocumentModel(
          id: 'national_id',
          title: 'National ID',
          icon: 'id_card',
          items: [
            DocumentSideItem(
              title: 'Front Side',
              status: DocumentStatus.verified,
              previewUrl: null,
            ),
            DocumentSideItem(
              title: 'Back Side',
              status: DocumentStatus.verified,
              previewUrl: null,
            ),
          ],
        ),
        const SellerDocumentModel(
          id: 'passport',
          title: 'Passport',
          icon: 'passport',
          items: [
            DocumentSideItem(
              title: 'Photo Page',
              status: DocumentStatus.pending,
              previewUrl: null,
            ),
          ],
        ),
        const SellerDocumentModel(
          id: 'driving_license',
          title: 'Driving License',
          icon: 'license',
          items: [
            DocumentSideItem(
              title: 'Photo Page',
              status: DocumentStatus.pending,
              previewUrl: null,
            ),
          ],
        ),
      ];
}
