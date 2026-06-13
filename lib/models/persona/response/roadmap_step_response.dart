import 'package:json_annotation/json_annotation.dart';

part 'roadmap_step_response.g.dart';

@JsonSerializable()
class RoadmapStepResponse {
  final String title;
  final String description;

  const RoadmapStepResponse({required this.title, required this.description});

  factory RoadmapStepResponse.fromJson(Map<String, dynamic> json) =>
      _$RoadmapStepResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoadmapStepResponseToJson(this);
}
