import '../../domain/entities/artist_profile_entity.dart';
import '../../domain/repositories/artist_profile_repository.dart';
import '../datasources/artist_profile_remote_data_source.dart';
import '../models/artist_profile_model.dart';

class ArtistProfileRepositoryImpl implements ArtistProfileRepository {
  final ArtistProfileRemoteDataSource remoteDataSource;

  ArtistProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ArtistProfileEntity> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<ArtistProfileEntity> updateProfile(ArtistProfileEntity profile) async {
    final model = ArtistProfileModel.fromEntity(profile);
    return await remoteDataSource.updateProfile(model);
  }
}
