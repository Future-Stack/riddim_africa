import '../../domain/entities/tracking_event_entity.dart';

class TrackingEventModel extends TrackingEventEntity {
  const TrackingEventModel({
    required super.title,
    required super.description,
    required super.date,
    super.isCompleted = false,
    super.isCurrent = false,
  });

  factory TrackingEventModel.fromJson(Map<String, dynamic> json) {
    return TrackingEventModel(
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isCurrent: json['isCurrent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': isCompleted,
      'isCurrent': isCurrent,
    };
  }
}
