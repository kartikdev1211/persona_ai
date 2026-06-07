import 'package:json_annotation/json_annotation.dart';

part 'persona_response.g.dart';

@JsonSerializable()
class PersonaResponse {
  @JsonKey(name: 'persona_name')
  final String personaName;

  @JsonKey(name: 'avatar_index')
  final int avatarIndex;

  @JsonKey(name: 'confidence_level')
  final String confidenceLevel;

  @JsonKey(name: 'focus_goal')
  final String focusGoal;

  const PersonaResponse({
    required this.personaName,
    required this.avatarIndex,
    required this.confidenceLevel,
    required this.focusGoal,
  });

  factory PersonaResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaResponseToJson(this);
}
