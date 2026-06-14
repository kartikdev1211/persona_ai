// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      fullName: json['full_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      confidenceScore: (json['confidence_score'] as num).toInt(),
      notificationsEnabled: json['notifications_enabled'] as bool,
      level: (json['level'] as num).toInt(),
      levelTitle: json['level_title'] as String,
      xp: (json['xp'] as num).toInt(),
      xpRequired: (json['xp_required'] as num).toInt(),
      dayStreak: (json['day_streak'] as num).toInt(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
      'confidence_score': instance.confidenceScore,
      'notifications_enabled': instance.notificationsEnabled,
      'level': instance.level,
      'level_title': instance.levelTitle,
      'xp': instance.xp,
      'xp_required': instance.xpRequired,
      'day_streak': instance.dayStreak,
      'achievements': instance.achievements,
    };
