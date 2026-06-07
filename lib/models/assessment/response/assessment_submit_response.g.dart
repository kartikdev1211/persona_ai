// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentSubmitResponse _$AssessmentSubmitResponseFromJson(
  Map<String, dynamic> json,
) => AssessmentSubmitResponse(
  message: json['message'] as String,
  assessmentCompleted: json['assessment_completed'] as bool,
);

Map<String, dynamic> _$AssessmentSubmitResponseToJson(
  AssessmentSubmitResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'assessment_completed': instance.assessmentCompleted,
};
