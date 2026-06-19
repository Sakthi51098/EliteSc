// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsEventModel _$SportsEventModelFromJson(Map<String, dynamic> json) =>
    SportsEventModel(
      idEvent: json['idEvent'] as String,
      strLeague: json['strLeague'] as String,
      strHomeTeam: json['strHomeTeam'] as String,
      strAwayTeam: json['strAwayTeam'] as String,
      dateEvent: json['dateEvent'] as String,
      strTime: json['strTime'] as String,
      strVenue: json['strVenue'] as String,
      intHomeScore: (json['intHomeScore'] as num?)?.toInt(),
      intAwayScore: (json['intAwayScore'] as num?)?.toInt(),
      strThumb: json['strThumb'] as String?,
    );

Map<String, dynamic> _$SportsEventModelToJson(SportsEventModel instance) =>
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
      'strThumb': instance.strThumb,
    };
