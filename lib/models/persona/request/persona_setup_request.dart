import 'package:json_annotation/json_annotation.dart';

part 'persona_setup_request.g.dart';

@JsonSerializable()
class PersonaSetupRequest {
  @JsonKey(name: 'persona_name')
  final String personaName;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @JsonKey(name: 'confidence_level')
  final String confidenceLevel;

  @JsonKey(name: 'focus_goal')
  final String focusGoal;

  const PersonaSetupRequest({
    required this.personaName,
    this.avatarUrl,
    required this.confidenceLevel,
    required this.focusGoal,
  });

  factory PersonaSetupRequest.fromJson(Map<String, dynamic> json) =>
      _$PersonaSetupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaSetupRequestToJson(this);
}
