import '../entities/faq_entity.dart';
import '../entities/policy_entity.dart';

abstract class SettingsRepository {
  Future<List<FaqEntity>> getFaqs();
  Future<List<PolicyEntity>> getPolicy(String policyType);
}
