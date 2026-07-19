import '../entities/faq_entity.dart';
import '../repositories/settings_repository.dart';

class GetFaqsUseCase {
  final SettingsRepository repository;

  GetFaqsUseCase(this.repository);

  Future<List<FaqEntity>> execute() async {
    return await repository.getFaqs();
  }
}
