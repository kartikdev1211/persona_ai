// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona_setup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaSetupRequest _$PersonaSetupRequestFromJson(Map<String, dynamic> json) =>
    PersonaSetupRequest(
      personaName: json['persona_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      confidenceLevel: json['confidence_level'] as String,
      focusGoal: json['focus_goal'] as String,
    );

Map<String, dynamic> _$PersonaSetupRequestToJson(
  PersonaSetupRequest instance,
) => <String, dynamic>{
  'persona_name': instance.personaName,
  'avatar_url': instance.avatarUrl,
  'confidence_level': instance.confidenceLevel,
  'focus_goal': instance.focusGoal,
};
