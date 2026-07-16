import '../entities/radio_state_entity.dart';
import '../repositories/radio_repository.dart';

class GetRadioStateUseCase {
  final RadioRepository repository;

  GetRadioStateUseCase(this.repository);

  Future<RadioStateEntity> execute() {
    return repository.getRadioState();
  }
}
