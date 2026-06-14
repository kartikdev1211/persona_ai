import 'package:json_annotation/json_annotation.dart';

part 'persona_response.g.dart';

@JsonSerializable()
class PersonaResponse {
  @JsonKey(name: 'persona_name')
  final String personaName;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @JsonKey(name: 'confidence_level')
  final String confidenceLevel;

  @JsonKey(name: 'focus_goal')
  final String focusGoal;

  const PersonaResponse({
    required this.personaName,
    this.avatarUrl,
    required this.confidenceLevel,
    required this.focusGoal,
  });

  factory PersonaResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaResponseToJson(this);

  PersonaResponse copyWith({
    String? personaName,
    String? avatarUrl,
    String? confidenceLevel,
    String? focusGoal,
  }) {
    return PersonaResponse(
      personaName: personaName ?? this.personaName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      focusGoal: focusGoal ?? this.focusGoal,
    );
  }
}
