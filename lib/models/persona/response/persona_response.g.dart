// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaResponse _$PersonaResponseFromJson(Map<String, dynamic> json) =>
    PersonaResponse(
      personaName: json['persona_name'] as String,
      avatarIndex: (json['avatar_index'] as num).toInt(),
      confidenceLevel: json['confidence_level'] as String,
      focusGoal: json['focus_goal'] as String,
    );

Map<String, dynamic> _$PersonaResponseToJson(PersonaResponse instance) =>
    <String, dynamic>{
      'persona_name': instance.personaName,
      'avatar_index': instance.avatarIndex,
      'confidence_level': instance.confidenceLevel,
      'focus_goal': instance.focusGoal,
    };
