class RadioStateEntity {
  final String title;
  final String subtitle;
  final int listenerCount;
  final bool isLive;
  final String logoUrl;
  final double volume;
  final bool isPlaying;

  const RadioStateEntity({
    required this.title,
    required this.subtitle,
    required this.listenerCount,
    required this.isLive,
    required this.logoUrl,
    required this.volume,
    required this.isPlaying,
  });

  RadioStateEntity copyWith({
    String? title,
    String? subtitle,
    int? listenerCount,
    bool? isLive,
    String? logoUrl,
    double? volume,
    bool? isPlaying,
  }) {
    return RadioStateEntity(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      listenerCount: listenerCount ?? this.listenerCount,
      isLive: isLive ?? this.isLive,
      logoUrl: logoUrl ?? this.logoUrl,
      volume: volume ?? this.volume,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
