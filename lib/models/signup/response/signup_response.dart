import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  final int id;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;

  const SignupResponse({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
