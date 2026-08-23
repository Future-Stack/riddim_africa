import 'package:get/get.dart';
import '../data/datasources/artist_verification_remote_data_source.dart';
import '../data/repositories/artist_verification_repository_impl.dart';
import '../domain/repositories/artist_verification_repository.dart';
import '../domain/usecases/submit_artist_verification_usecase.dart';
import '../presentation/controllers/artist_verification_controller.dart';

class ArtistVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistVerificationRemoteDataSource>(
      () => ArtistVerificationRemoteDataSource(),
    );
    Get.lazyPut<ArtistVerificationRepository>(
      () => ArtistVerificationRepositoryImpl(
        Get.find<ArtistVerificationRemoteDataSource>(),
      ),
    );
    Get.lazyPut(
      () => SubmitArtistVerificationUseCase(
        Get.find<ArtistVerificationRepository>(),
      ),
    );
    Get.lazyPut(
      () => ArtistVerificationController(
        submitArtistVerificationUseCase:
            Get.find<SubmitArtistVerificationUseCase>(),
      ),
    );
  }
}
