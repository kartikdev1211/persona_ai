import 'package:json_annotation/json_annotation.dart';

part 'avatar_upload_response.g.dart';

@JsonSerializable()
class AvatarUploadResponse {
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  const AvatarUploadResponse({required this.avatarUrl});

  factory AvatarUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$AvatarUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarUploadResponseToJson(this);
}
