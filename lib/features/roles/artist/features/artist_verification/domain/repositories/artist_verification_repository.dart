import '../entities/artist_verification_entity.dart';

abstract class ArtistVerificationRepository {
  Future<ArtistVerificationEntity> submitVerification({
    required String filePath,
    required String fileName,
  });
}
