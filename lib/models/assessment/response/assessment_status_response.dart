import 'package:json_annotation/json_annotation.dart';

part 'assessment_status_response.g.dart';

@JsonSerializable()
class AssessmentStatusResponse {
  @JsonKey(name: 'assessment_completed')
  final bool assessmentCompleted;

  const AssessmentStatusResponse({required this.assessmentCompleted});

  factory AssessmentStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$AssessmentStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentStatusResponseToJson(this);
}
