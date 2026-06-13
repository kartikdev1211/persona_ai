// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNotificationRequest _$UpdateNotificationRequestFromJson(
  Map<String, dynamic> json,
) => UpdateNotificationRequest(
  notificationsEnabled: json['notifications_enabled'] as bool,
);

Map<String, dynamic> _$UpdateNotificationRequestToJson(
  UpdateNotificationRequest instance,
) => <String, dynamic>{'notifications_enabled': instance.notificationsEnabled};
