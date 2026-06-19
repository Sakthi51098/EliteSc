// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsEventResponseModel _$SportsEventResponseModelFromJson(
  Map<String, dynamic> json,
) => SportsEventResponseModel(
  events: (json['events'] as List<dynamic>?)
      ?.map((e) => SportsEventModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SportsEventResponseModelToJson(
  SportsEventResponseModel instance,
) => <String, dynamic>{'events': instance.events};
