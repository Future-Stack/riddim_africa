import 'package:get/get.dart';
import '../data/datasources/profile_remote_data_source.dart';
import '../presentation/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ProfileRemoteDataSource>()) {
      Get.lazyPut<ProfileRemoteDataSource>(() => ProfileRemoteDataSource());
    }
    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut<ProfileController>(
        () => ProfileController(
          remoteDataSource: Get.find<ProfileRemoteDataSource>(),
        ),
      );
    }
  }
}
