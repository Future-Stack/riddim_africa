import '../../domain/entities/artist_verification_entity.dart';

class ArtistVerificationModel extends ArtistVerificationEntity {
  const ArtistVerificationModel({
    super.documentPath,
    super.documentName,
    super.documentSizeBytes,
    required super.status,
    required super.submittedAt,
  });

  factory ArtistVerificationModel.fromJson(Map<String, dynamic> json) {
    return ArtistVerificationModel(
      documentPath: json['document_path'] as String?,
      documentName: json['document_name'] as String?,
      documentSizeBytes: json['document_size_bytes'] as int?,
      status: json['status'] as String? ?? 'pending',
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_path': documentPath,
      'document_name': documentName,
      'document_size_bytes': documentSizeBytes,
      'status': status,
      'submitted_at': submittedAt.toIso8601String(),
    };
  }
}
