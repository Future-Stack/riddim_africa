import '../entities/artist_verification_entity.dart';
import '../repositories/artist_verification_repository.dart';

class SubmitArtistVerificationUseCase {
  final ArtistVerificationRepository repository;

  SubmitArtistVerificationUseCase(this.repository);

  Future<ArtistVerificationEntity> call({
    required String filePath,
    required String fileName,
  }) async {
    return await repository.submitVerification(
      filePath: filePath,
      fileName: fileName,
    );
  }
}
