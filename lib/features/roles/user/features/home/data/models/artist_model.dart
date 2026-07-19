import '../../domain/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  const ArtistModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.genre,
    required super.followers,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      genre: json['genre'] as String,
      followers: json['followers'] as String? ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'genre': genre,
      'followers': followers,
    };
  }
}
