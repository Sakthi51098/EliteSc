// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDetailsResponseModel _$GameDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => GameDetailsResponseModel(
  events: (json['events'] as List<dynamic>?)
      ?.map((e) => GameDetailsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GameDetailsResponseModelToJson(
  GameDetailsResponseModel instance,
) => <String, dynamic>{'events': instance.events};
