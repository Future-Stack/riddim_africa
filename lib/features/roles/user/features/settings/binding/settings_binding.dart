import 'package:get/get.dart';
import '../data/datasources/settings_local_data_source.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/usecases/get_faqs_usecase.dart';
import '../domain/usecases/get_policy_usecase.dart';
import '../presentation/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsLocalDataSource>(() => SettingsLocalDataSourceImpl());
    Get.lazyPut<SettingsRepository>(() => SettingsRepositoryImpl(Get.find<SettingsLocalDataSource>()));
    Get.lazyPut(() => GetFaqsUseCase(Get.find<SettingsRepository>()));
    Get.lazyPut(() => GetPolicyUseCase(Get.find<SettingsRepository>()));
    
    Get.lazyPut<SettingsController>(() => SettingsController(
      getFaqsUseCase: Get.find<GetFaqsUseCase>(),
      getPolicyUseCase: Get.find<GetPolicyUseCase>(),
    ));
  }
}
