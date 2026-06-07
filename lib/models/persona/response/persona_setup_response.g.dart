// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona_setup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonaSetupResponse _$PersonaSetupResponseFromJson(
  Map<String, dynamic> json,
) => PersonaSetupResponse(
  message: json['message'] as String,
  personaSetupCompleted: json['persona_setup_completed'] as bool,
);

Map<String, dynamic> _$PersonaSetupResponseToJson(
  PersonaSetupResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'persona_setup_completed': instance.personaSetupCompleted,
};
