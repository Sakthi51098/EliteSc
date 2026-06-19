import 'package:json_annotation/json_annotation.dart';

import 'game_details_model.dart';

part 'game_details_response_model.g.dart';

@JsonSerializable()
class GameDetailsResponseModel {
  const GameDetailsResponseModel({required this.events});

  factory GameDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return _$GameDetailsResponseModelFromJson(json);
  }

  final List<GameDetailsModel>? events;

  Map<String, dynamic> toJson() => _$GameDetailsResponseModelToJson(this);
}
