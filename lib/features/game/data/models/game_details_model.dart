import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/game_details_entity.dart';

part 'game_details_model.g.dart';

@JsonSerializable()
class GameDetailsModel {
  const GameDetailsModel({
    required this.idEvent,
    required this.strLeague,
    required this.strHomeTeam,
    required this.strAwayTeam,
    required this.dateEvent,
    required this.strTime,
    required this.strVenue,
    this.intHomeScore,
    this.intAwayScore,
  });

  factory GameDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$GameDetailsModelFromJson(json);
  }

  final String idEvent;
  final String strLeague;
  final String strHomeTeam;
  final String strAwayTeam;
  final String dateEvent;
  final String strTime;
  final String strVenue;
  final int? intHomeScore;
  final int? intAwayScore;

  Map<String, dynamic> toJson() => _$GameDetailsModelToJson(this);

  GameDetailsEntity toEntity() {
    return GameDetailsEntity(
      id: idEvent,
      title: 'Rummy',
      description: 'Live sports update powered by TheSportsDB',
      league: strLeague,
      homeTeam: strHomeTeam,
      awayTeam: strAwayTeam,
      eventDate: dateEvent,
      eventTime: strTime,
      venue: strVenue,
      homeScore: intHomeScore,
      awayScore: intAwayScore,
    );
  }
}
