import 'package:get/get.dart';
import '../data/datasources/home_local_data_source.dart';
import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';
import '../domain/usecases/get_home_products_usecase.dart';
import '../presentation/controllers/user_home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLocalDataSource>(() => HomeLocalDataSourceImpl());
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find<HomeLocalDataSource>()));
    Get.lazyPut(() => GetHomeProductsUseCase(Get.find<HomeRepository>()));
    Get.lazyPut(() => UserHomeController(Get.find<GetHomeProductsUseCase>()));
  }
}
