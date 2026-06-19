// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDetailsModel _$GameDetailsModelFromJson(Map<String, dynamic> json) =>
    GameDetailsModel(
      idEvent: json['idEvent'] as String,
      strLeague: json['strLeague'] as String,
      strHomeTeam: json['strHomeTeam'] as String,
      strAwayTeam: json['strAwayTeam'] as String,
      dateEvent: json['dateEvent'] as String,
      strTime: json['strTime'] as String,
      strVenue: json['strVenue'] as String,
      intHomeScore: (json['intHomeScore'] as num?)?.toInt(),
      intAwayScore: (json['intAwayScore'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GameDetailsModelToJson(GameDetailsModel instance) =>
    <String, dynamic>{
      'idEvent': instance.idEvent,
      'strLeague': instance.strLeague,
      'strHomeTeam': instance.strHomeTeam,
      'strAwayTeam': instance.strAwayTeam,
      'dateEvent': instance.dateEvent,
      'strTime': instance.strTime,
      'strVenue': instance.strVenue,
      'intHomeScore': instance.intHomeScore,
      'intAwayScore': instance.intAwayScore,
    };
