import 'package:json_annotation/json_annotation.dart';

part 'assessment_request.g.dart';

@JsonSerializable()
class AssessmentRequest {
  @JsonKey(name: 'social_situation')
  final String socialSituation;

  @JsonKey(name: 'current_goal')
  final String currentGoal;

  @JsonKey(name: 'self_improvement_consistency')
  final String selfImprovementConsistency;

  @JsonKey(name: 'biggest_obstacle')
  final String biggestObstacle;

  const AssessmentRequest({
    required this.socialSituation,
    required this.currentGoal,
    required this.selfImprovementConsistency,
    required this.biggestObstacle,
  });

  factory AssessmentRequest.fromJson(Map<String, dynamic> json) =>
      _$AssessmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentRequestToJson(this);
}
