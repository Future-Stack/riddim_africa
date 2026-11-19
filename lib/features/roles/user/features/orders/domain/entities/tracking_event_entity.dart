class TrackingEventEntity {
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final bool isCurrent;

  const TrackingEventEntity({
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}
