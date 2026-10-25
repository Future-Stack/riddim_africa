import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/core/models/response_data.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<ResponseData> execute(String email) {
    return repository.forgotPassword(email);
  }
}
