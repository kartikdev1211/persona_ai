// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentRequest _$AssessmentRequestFromJson(Map<String, dynamic> json) =>
    AssessmentRequest(
      socialSituation: json['social_situation'] as String,
      currentGoal: json['current_goal'] as String,
      selfImprovementConsistency:
          json['self_improvement_consistency'] as String,
      biggestObstacle: json['biggest_obstacle'] as String,
    );

Map<String, dynamic> _$AssessmentRequestToJson(AssessmentRequest instance) =>
    <String, dynamic>{
      'social_situation': instance.socialSituation,
      'current_goal': instance.currentGoal,
      'self_improvement_consistency': instance.selfImprovementConsistency,
      'biggest_obstacle': instance.biggestObstacle,
    };
