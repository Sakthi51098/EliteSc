import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/free_game_entity.dart';

part 'free_game_model.g.dart';

@JsonSerializable()
class FreeGameModel {
  const FreeGameModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.profileUrl,
  });

  factory FreeGameModel.fromJson(Map<String, dynamic> json) {
    return _$FreeGameModelFromJson(json);
  }

  final int id;
  final String title;
  final String thumbnail;
  @JsonKey(name: 'short_description')
  final String shortDescription;
  @JsonKey(name: 'game_url')
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'freetogame_profile_url')
  final String profileUrl;

  Map<String, dynamic> toJson() => _$FreeGameModelToJson(this);

  FreeGameEntity toEntity() {
    return FreeGameEntity(
      id: id,
      title: title,
      thumbnail: thumbnail,
      shortDescription: shortDescription,
      gameUrl: gameUrl,
      genre: genre,
      platform: platform,
      publisher: publisher,
      developer: developer,
      releaseDate: releaseDate,
      profileUrl: profileUrl,
    );
  }
}
