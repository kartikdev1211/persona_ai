import 'package:json_annotation/json_annotation.dart';

part 'update_notification_request.g.dart';

@JsonSerializable()
class UpdateNotificationRequest {
  @JsonKey(name: 'notifications_enabled')
  final bool notificationsEnabled;

  const UpdateNotificationRequest({required this.notificationsEnabled});

  factory UpdateNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNotificationRequestToJson(this);
}
