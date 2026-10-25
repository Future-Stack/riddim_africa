import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/core/models/response_data.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<ResponseData> execute({
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    return repository.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }
}
