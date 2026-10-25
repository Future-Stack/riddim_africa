import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/core/models/response_data.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<ResponseData> execute({
    required String email,
    required String otp,
    String otpType = 'REGISTRATION',
  }) {
    return repository.verifyOtp(
      email: email,
      otp: otp,
      otpType: otpType,
    );
  }
}
