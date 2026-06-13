import 'package:json_annotation/json_annotation.dart';

part 'assessment_status_response.g.dart';

@JsonSerializable()
class AssessmentStatusResponse {
  @JsonKey(name: 'assessment_completed')
  final bool assessmentCompleted;

  @JsonKey(name: 'is_persona_setup_completed')
  final bool isPersonaSetupCompleted;

  @JsonKey(name: 'is_report_generated')
  final bool isReportGenerated;

  const AssessmentStatusResponse({
    required this.assessmentCompleted,
    required this.isPersonaSetupCompleted,
    required this.isReportGenerated,
  });

  factory AssessmentStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$AssessmentStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentStatusResponseToJson(this);
}
