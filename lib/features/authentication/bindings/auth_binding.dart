import 'package:get/get.dart';
import 'package:riddimafrica/core/services/network/network_caller.dart';
import 'package:riddimafrica/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:riddimafrica/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/login_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/register_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/resend_otp_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:riddimafrica/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:riddimafrica/features/authentication/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut<NetworkCaller>(() => NetworkCaller());
    }

    if (!Get.isRegistered<AuthRemoteDataSource>()) {
      Get.lazyPut<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(Get.find<NetworkCaller>()),
      );
    }

    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      );
    }

    if (!Get.isRegistered<LoginUseCase>()) {
      Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<AuthRepository>()));
    }
    if (!Get.isRegistered<RegisterUseCase>()) {
      Get.lazyPut<RegisterUseCase>(
        () => RegisterUseCase(Get.find<AuthRepository>()),
      );
    }
    if (!Get.isRegistered<VerifyOtpUseCase>()) {
      Get.lazyPut<VerifyOtpUseCase>(
        () => VerifyOtpUseCase(Get.find<AuthRepository>()),
      );
    }
    if (!Get.isRegistered<ResendOtpUseCase>()) {
      Get.lazyPut<ResendOtpUseCase>(
        () => ResendOtpUseCase(Get.find<AuthRepository>()),
      );
    }
    if (!Get.isRegistered<ForgotPasswordUseCase>()) {
      Get.lazyPut<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(Get.find<AuthRepository>()),
      );
    }
    if (!Get.isRegistered<ResetPasswordUseCase>()) {
      Get.lazyPut<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(Get.find<AuthRepository>()),
      );
    }

    if (!Get.isRegistered<AuthController>()) {
      Get.put<AuthController>(
        AuthController(
          loginUseCase: Get.find<LoginUseCase>(),
          registerUseCase: Get.find<RegisterUseCase>(),
          verifyOtpUseCase: Get.find<VerifyOtpUseCase>(),
          resendOtpUseCase: Get.find<ResendOtpUseCase>(),
          forgotPasswordUseCase: Get.find<ForgotPasswordUseCase>(),
          resetPasswordUseCase: Get.find<ResetPasswordUseCase>(),
        ),
        permanent: true,
      );
    }
  }
}
