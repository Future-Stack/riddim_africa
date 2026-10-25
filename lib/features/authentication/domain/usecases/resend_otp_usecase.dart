import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/core/models/response_data.dart';

class ResendOtpUseCase {
  final AuthRepository repository;

  ResendOtpUseCase(this.repository);

  Future<ResponseData> execute(String email) {
    return repository.resendOtp(email);
  }
}
