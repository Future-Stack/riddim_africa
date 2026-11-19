import '../../domain/entities/radio_state_entity.dart';

class RadioStateModel extends RadioStateEntity {
  const RadioStateModel({
    required super.title,
    required super.subtitle,
    required super.listenerCount,
    required super.isLive,
    required super.logoUrl,
    required super.volume,
    required super.isPlaying,
  });

  factory RadioStateModel.fromJson(Map<String, dynamic> json) {
    return RadioStateModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      listenerCount: json['listenerCount'] ?? 0,
      isLive: json['isLive'] ?? false,
      logoUrl: json['logoUrl'] ?? '',
      volume: (json['volume'] as num? ?? 1.0).toDouble(),
      isPlaying: json['isPlaying'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'listenerCount': listenerCount,
      'isLive': isLive,
      'logoUrl': logoUrl,
      'volume': volume,
      'isPlaying': isPlaying,
    };
  }
}
