import '../repositories/order_repository.dart';
import '../entities/tracking_event_entity.dart';

class GetTrackingEventsUseCase {
  final OrderRepository _repository;

  GetTrackingEventsUseCase(this._repository);

  Future<List<TrackingEventEntity>> execute(String orderId) =>
      _repository.getTrackingEvents(orderId);
}
