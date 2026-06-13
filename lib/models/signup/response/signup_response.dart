import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'token_type')
  final String tokenType;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;

  const SignupResponse({
    required this.accessToken,
    required this.tokenType,
    required this.fullName,
    required this.email,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
