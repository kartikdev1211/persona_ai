import 'package:json_annotation/json_annotation.dart';
import 'package:persona_ai/models/persona/response/roadmap_step_response.dart';

part 'persona_report_response.g.dart';

@JsonSerializable()
class PersonaReportResponse {
  @JsonKey(name: 'confidence_score')
  final double confidenceScore;

  @JsonKey(name: 'discipline_score')
  final double disciplineScore;

  @JsonKey(name: 'social_growth_score')
  final double socialGrowthScore;

  final List<String> strengths;
  final List<String> weaknesses;
  final List<RoadmapStepResponse> roadmap;

  const PersonaReportResponse({
    required this.confidenceScore,
    required this.disciplineScore,
    required this.socialGrowthScore,
    required this.strengths,
    required this.weaknesses,
    required this.roadmap,
  });

  factory PersonaReportResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonaReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaReportResponseToJson(this);
}
