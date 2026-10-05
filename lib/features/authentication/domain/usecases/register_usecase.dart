import 'package:riddimafrica/features/authentication/domain/repositories/auth_repository.dart';
import 'package:riddimafrica/core/models/response_data.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<ResponseData> execute(Map<String, dynamic> body, {String role = 'User'}) {
    return repository.register(body, role: role);
  }
}
