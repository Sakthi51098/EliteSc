import 'package:json_annotation/json_annotation.dart';

import 'sports_event_model.dart';

part 'sports_event_response_model.g.dart';

@JsonSerializable()
class SportsEventResponseModel {
  const SportsEventResponseModel({required this.events});

  factory SportsEventResponseModel.fromJson(Map<String, dynamic> json) {
    return _$SportsEventResponseModelFromJson(json);
  }

  final List<SportsEventModel>? events;

  Map<String, dynamic> toJson() => _$SportsEventResponseModelToJson(this);
}
