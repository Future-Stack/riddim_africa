import '../../domain/entities/artist_verification_entity.dart';
import '../../domain/repositories/artist_verification_repository.dart';
import '../datasources/artist_verification_remote_data_source.dart';

class ArtistVerificationRepositoryImpl implements ArtistVerificationRepository {
  final ArtistVerificationRemoteDataSource remoteDataSource;

  ArtistVerificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<ArtistVerificationEntity> submitVerification({
    required String filePath,
    required String fileName,
  }) async {
    return await remoteDataSource.submitVerification(
      filePath: filePath,
      fileName: fileName,
    );
  }
}
