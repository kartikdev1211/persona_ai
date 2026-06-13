import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfile extends ProfileEvent {
  const FetchProfile();
}

class UpdateNotificationPreference extends ProfileEvent {
  final bool enabled;
  const UpdateNotificationPreference(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class DeleteAccountRequested extends ProfileEvent {
  final String password;
  const DeleteAccountRequested(this.password);

  @override
  List<Object?> get props => [password];
}
