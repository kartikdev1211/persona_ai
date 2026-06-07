import 'package:json_annotation/json_annotation.dart';

part 'assessment_submit_response.g.dart';

@JsonSerializable()
class AssessmentSubmitResponse {
  final String message;

  @JsonKey(name: 'assessment_completed')
  final bool assessmentCompleted;

  const AssessmentSubmitResponse({
    required this.message,
    required this.assessmentCompleted,
  });

  factory AssessmentSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$AssessmentSubmitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentSubmitResponseToJson(this);
}
