import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest {
  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;
  final String password;

  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  const SignupRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
