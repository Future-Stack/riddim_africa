import '../entities/policy_entity.dart';
import '../repositories/settings_repository.dart';

class GetPolicyUseCase {
  final SettingsRepository repository;

  GetPolicyUseCase(this.repository);

  Future<List<PolicyEntity>> execute(String policyType) async {
    return await repository.getPolicy(policyType);
  }
}
