// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaReportResponse _$PersonaReportResponseFromJson(
  Map<String, dynamic> json,
) => PersonaReportResponse(
  confidenceScore: (json['confidence_score'] as num).toDouble(),
  disciplineScore: (json['discipline_score'] as num).toDouble(),
  socialGrowthScore: (json['social_growth_score'] as num).toDouble(),
  strengths: (json['strengths'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  weaknesses: (json['weaknesses'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  roadmap: (json['roadmap'] as List<dynamic>)
      .map((e) => RoadmapStepResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PersonaReportResponseToJson(
  PersonaReportResponse instance,
) => <String, dynamic>{
  'confidence_score': instance.confidenceScore,
  'discipline_score': instance.disciplineScore,
  'social_growth_score': instance.socialGrowthScore,
  'strengths': instance.strengths,
  'weaknesses': instance.weaknesses,
  'roadmap': instance.roadmap,
};
