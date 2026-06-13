import 'package:equatable/equatable.dart';
import 'package:persona_ai/models/persona/response/persona_response.dart';
import 'package:persona_ai/models/profile/response/profile_response.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
  updating,
  deleting,
  accountDeleted,
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileResponse? profile;
  final PersonaResponse? persona;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.persona,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileResponse? profile,
    PersonaResponse? persona,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      persona: persona ?? this.persona,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, persona, errorMessage];
}
