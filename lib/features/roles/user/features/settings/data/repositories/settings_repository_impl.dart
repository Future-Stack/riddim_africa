import '../../domain/entities/faq_entity.dart';
import '../../domain/entities/policy_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource dataSource;

  SettingsRepositoryImpl(this.dataSource);

  @override
  Future<List<FaqEntity>> getFaqs() async {
    return await dataSource.getMockFaqs();
  }

  @override
  Future<List<PolicyEntity>> getPolicy(String policyType) async {
    return await dataSource.getMockPolicy(policyType);
  }
}
