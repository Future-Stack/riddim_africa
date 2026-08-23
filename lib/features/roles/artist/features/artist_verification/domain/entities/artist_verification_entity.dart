class ArtistVerificationEntity {
  final String? documentPath;
  final String? documentName;
  final int? documentSizeBytes;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime submittedAt;

  const ArtistVerificationEntity({
    this.documentPath,
    this.documentName,
    this.documentSizeBytes,
    required this.status,
    required this.submittedAt,
  });
}
