import 'package:json_annotation/json_annotation.dart';

part 'persona_setup_response.g.dart';

@JsonSerializable()
class PersonaSetupResponse {
  final String message;

  @JsonKey(name: 'persona_setup_completed')
  final bool personaSetupCompleted;

  const PersonaSetupResponse({
    required this.message,
    required this.personaSetupCompleted,
  });

  factory PersonaSetupResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonaSetupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonaSetupResponseToJson(this);
}
