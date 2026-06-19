import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/sports_event_entity.dart';

part 'sports_event_model.g.dart';

@JsonSerializable()
class SportsEventModel {
  const SportsEventModel({
    required this.idEvent,
    required this.strLeague,
    required this.strHomeTeam,
    required this.strAwayTeam,
    required this.dateEvent,
    required this.strTime,
    required this.strVenue,
    this.intHomeScore,
    this.intAwayScore,
    this.strThumb,
  });

  factory SportsEventModel.fromJson(Map<String, dynamic> json) {
    return _$SportsEventModelFromJson(json);
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
  final String? strThumb;

  Map<String, dynamic> toJson() => _$SportsEventModelToJson(this);

  SportsEventEntity toEntity() {
    return SportsEventEntity(
      id: idEvent,
      league: strLeague,
      homeTeam: strHomeTeam,
      awayTeam: strAwayTeam,
      eventDate: dateEvent,
      eventTime: strTime,
      venue: strVenue,
      homeScore: intHomeScore,
      awayScore: intAwayScore,
      thumbnail: strThumb,
    );
  }
}
