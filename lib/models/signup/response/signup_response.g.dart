// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'full_name': instance.fullName,
      'email': instance.email,
    };
