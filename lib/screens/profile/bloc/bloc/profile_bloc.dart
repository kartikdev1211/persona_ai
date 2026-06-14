import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/network/api_result.dart';
import 'package:persona_ai/core/network/repository/persona_repository.dart';
import 'package:persona_ai/core/network/repository/profile_repository.dart';
import 'package:persona_ai/models/profile/response/profile_response.dart';
import 'package:persona_ai/screens/profile/bloc/event/profile_event.dart';
import 'package:persona_ai/screens/profile/bloc/state/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final PersonaRepository _personaRepository;

  ProfileBloc({
    required ProfileRepository repository,
    required PersonaRepository personaRepository,
  }) : _repository = repository,
       _personaRepository = personaRepository,
       super(const ProfileState()) {
    on<FetchProfile>(_onFetchProfile);
    on<UpdateNotificationPreference>(_onUpdateNotifications);
    on<DeleteAccountRequested>(_onDeleteAccount);
    on<UpdateAvatar>(_onUpdateAvatar);
  }

  Future<void> _onUpdateAvatar(
    UpdateAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.updating));

    // 1. Upload the image
    final uploadResult = await _personaRepository.uploadAvatar(
      File(event.imagePath),
    );

    if (uploadResult is ApiFailure) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: (uploadResult as ApiFailure).exception.message,
        ),
      );
      return;
    }

    final avatarUrl = (uploadResult as ApiSuccess).data.avatarUrl;

    // 2. Update persona with new avatarUrl
    // We need existing persona details to call setupPersona (which acts as update)
    final persona = state.persona;
    if (persona == null) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: "Persona data not loaded",
        ),
      );
      return;
    }

    final setupResult = await _personaRepository.setupPersona(
      personaName: persona.personaName,
      avatarUrl: avatarUrl,
      confidenceLevel: persona.confidenceLevel,
      focusGoal: persona.focusGoal,
    );

    switch (setupResult) {
      case ApiSuccess():
        // Optimistically update profile and persona in state
        final updatedProfile = state.profile?.copyWith(avatarUrl: avatarUrl);
        final updatedPersona = persona.copyWith(avatarUrl: avatarUrl);
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            profile: updatedProfile,
            persona: updatedPersona,
          ),
        );
      case ApiFailure(:final exception):
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: exception.message,
          ),
        );
    }
  }

  Future<void> _onFetchProfile(
    FetchProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final profileResult = await _repository.getProfile();
    final personaResult = await _personaRepository.getMyPersona();

    ProfileResponse? profileData;
    String? error;

    if (profileResult case ApiSuccess(:final data)) {
      profileData = data;
    } else if (profileResult case ApiFailure(:final exception)) {
      error = exception.message;
    }

    if (error != null) {
      emit(state.copyWith(status: ProfileStatus.failure, errorMessage: error));
      return;
    }

    switch (personaResult) {
      case ApiSuccess(:final data):
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            profile: profileData,
            persona: data,
          ),
        );
      case ApiFailure(:final exception):
        // If persona fails but profile succeeds, we still show profile
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            profile: profileData,
            errorMessage: exception.message,
          ),
        );
    }
  }

  Future<void> _onUpdateNotifications(
    UpdateNotificationPreference event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.updating));
    final result = await _repository.updateNotifications(
      enabled: event.enabled,
    );
    switch (result) {
      case ApiSuccess():
        // Optimistically update or refetch
        if (state.profile != null) {
          final updatedProfile = state.profile!.copyWith(
            notificationsEnabled: event.enabled,
          );
          emit(
            state.copyWith(
              status: ProfileStatus.success,
              profile: updatedProfile,
            ),
          );
        } else {
          add(const FetchProfile());
        }
      case ApiFailure(:final exception):
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: exception.message,
          ),
        );
    }
  }

  Future<void> _onDeleteAccount(
    DeleteAccountRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.deleting));
    final result = await _repository.deleteAccount(password: event.password);
    switch (result) {
      case ApiSuccess():
        emit(state.copyWith(status: ProfileStatus.accountDeleted));
      case ApiFailure(:final exception):
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: exception.message,
          ),
        );
    }
  }
}

// Extension to help with profile copying if generated class doesn't have it
extension ProfileResponseExtension on ProfileResponse {
  ProfileResponse copyWith({
    String? fullName,
    String? avatarUrl,
    int? confidenceScore,
    bool? notificationsEnabled,
    int? level,
    String? levelTitle,
    int? xp,
    int? xpRequired,
    int? dayStreak,
    List<String>? achievements,
  }) {
    return ProfileResponse(
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      level: level ?? this.level,
      levelTitle: levelTitle ?? this.levelTitle,
      xp: xp ?? this.xp,
      xpRequired: xpRequired ?? this.xpRequired,
      dayStreak: dayStreak ?? this.dayStreak,
      achievements: achievements ?? this.achievements,
    );
  }
}
