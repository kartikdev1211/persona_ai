// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentStatusResponse _$AssessmentStatusResponseFromJson(
  Map<String, dynamic> json,
) => AssessmentStatusResponse(
  assessmentCompleted: json['assessment_completed'] as bool,
  isPersonaSetupCompleted: json['is_persona_setup_completed'] as bool,
  isReportGenerated: json['is_report_generated'] as bool,
);

Map<String, dynamic> _$AssessmentStatusResponseToJson(
  AssessmentStatusResponse instance,
) => <String, dynamic>{
  'assessment_completed': instance.assessmentCompleted,
  'is_persona_setup_completed': instance.isPersonaSetupCompleted,
  'is_report_generated': instance.isReportGenerated,
};
