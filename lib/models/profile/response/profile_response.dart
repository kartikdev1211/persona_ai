import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @JsonKey(name: 'confidence_score')
  final int confidenceScore;

  @JsonKey(name: 'notifications_enabled')
  final bool notificationsEnabled;

  final int level;

  @JsonKey(name: 'level_title')
  final String levelTitle;

  final int xp;

  @JsonKey(name: 'xp_required')
  final int xpRequired;

  @JsonKey(name: 'day_streak')
  final int dayStreak;

  final List<String> achievements;

  const ProfileResponse({
    required this.fullName,
    this.avatarUrl,
    required this.confidenceScore,
    required this.notificationsEnabled,
    required this.level,
    required this.levelTitle,
    required this.xp,
    required this.xpRequired,
    required this.dayStreak,
    required this.achievements,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
