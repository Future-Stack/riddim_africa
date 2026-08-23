import 'package:get/get.dart';
import '../data/datasources/artist_profile_remote_data_source.dart';
import '../data/repositories/artist_profile_repository_impl.dart';
import '../domain/repositories/artist_profile_repository.dart';
import '../domain/usecases/get_artist_profile_usecase.dart';
import '../domain/usecases/update_artist_profile_usecase.dart';
import '../presentation/controllers/artist_profile_controller.dart';

import '../presentation/controllers/artist_followers_ratings_controller.dart';
import '../presentation/controllers/artist_support_controller.dart';
import '../presentation/controllers/artist_payment_controller.dart';
import '../presentation/controllers/artist_documents_controller.dart';
import '../presentation/controllers/artist_live_chat_controller.dart';

class ArtistProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtistProfileRemoteDataSource>(
      () => ArtistProfileRemoteDataSource(),
    );
    Get.lazyPut<ArtistProfileRepository>(
      () => ArtistProfileRepositoryImpl(Get.find<ArtistProfileRemoteDataSource>()),
    );
    Get.lazyPut(
      () => GetArtistProfileUseCase(Get.find<ArtistProfileRepository>()),
    );
    Get.lazyPut(
      () => UpdateArtistProfileUseCase(Get.find<ArtistProfileRepository>()),
    );
    Get.lazyPut(
      () => ArtistProfileController(
        getArtistProfileUseCase: Get.find<GetArtistProfileUseCase>(),
        updateArtistProfileUseCase: Get.find<UpdateArtistProfileUseCase>(),
      ),
    );
    Get.lazyPut(() => ArtistFollowersRatingsController());
    Get.lazyPut(() => ArtistSupportController());
    Get.lazyPut(() => ArtistPaymentController());
    Get.lazyPut(() => ArtistDocumentsController());
    Get.lazyPut(() => ArtistLiveChatController());
  }
}
