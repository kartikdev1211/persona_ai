// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentResponse _$AssessmentResponseFromJson(Map<String, dynamic> json) =>
    AssessmentResponse(
      socialSituation: json['social_situation'] as String,
      currentGoal: json['current_goal'] as String,
      selfImprovementConsistency:
          json['self_improvement_consistency'] as String,
      biggestObstacle: json['biggest_obstacle'] as String,
    );

Map<String, dynamic> _$AssessmentResponseToJson(AssessmentResponse instance) =>
    <String, dynamic>{
      'social_situation': instance.socialSituation,
      'current_goal': instance.currentGoal,
      'self_improvement_consistency': instance.selfImprovementConsistency,
      'biggest_obstacle': instance.biggestObstacle,
    };
