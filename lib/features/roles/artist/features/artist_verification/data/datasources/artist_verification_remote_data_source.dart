import '../models/artist_verification_model.dart';

class ArtistVerificationRemoteDataSource {
  Future<ArtistVerificationModel> submitVerification({
    required String filePath,
    required String fileName,
  }) async {
    // Simulate real network upload
    await Future.delayed(const Duration(milliseconds: 1200));

    return ArtistVerificationModel(
      documentPath: filePath,
      documentName: fileName,
      documentSizeBytes: 1024 * 1024 * 2, // ~2MB
      status: 'pending',
      submittedAt: DateTime.now(),
    );
  }
}
