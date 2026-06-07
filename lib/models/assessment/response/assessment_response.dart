import 'package:json_annotation/json_annotation.dart';

part 'assessment_response.g.dart';

@JsonSerializable()
class AssessmentResponse {
  @JsonKey(name: 'social_situation')
  final String socialSituation;

  @JsonKey(name: 'current_goal')
  final String currentGoal;

  @JsonKey(name: 'self_improvement_consistency')
  final String selfImprovementConsistency;

  @JsonKey(name: 'biggest_obstacle')
  final String biggestObstacle;

  const AssessmentResponse({
    required this.socialSituation,
    required this.currentGoal,
    required this.selfImprovementConsistency,
    required this.biggestObstacle,
  });

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentResponseToJson(this);
}
