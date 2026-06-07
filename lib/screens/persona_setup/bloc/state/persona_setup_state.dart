// lib/screens/persona_setup/bloc/state/persona_setup_state.dart

enum SetupStep { name, avatar, confidence, focus }

class PersonaSetupState {
  final SetupStep currentStep;
  final String userName;
  final int avatarIndex;
  final double confidenceLevel;
  final int focusGoalIndex;
  final bool isLoading;
  final bool isCompleted;
  final String? errorMessage;

  PersonaSetupState({
    this.currentStep = SetupStep.name,
    this.userName = '',
    this.avatarIndex = 0,
    this.confidenceLevel = 0.5,
    this.focusGoalIndex = 0,
    this.isLoading = false,
    this.isCompleted = false,
    this.errorMessage,
  });

  bool get isFirst => currentStep == SetupStep.name;
  bool get isLast => currentStep == SetupStep.focus;
  int get stepIndex => currentStep.index;
  int get totalSteps => SetupStep.values.length;

  bool canProceed() {
    switch (currentStep) {
      case SetupStep.name:
        return userName.trim().length >= 2;
      case SetupStep.avatar:
      case SetupStep.confidence:
      case SetupStep.focus:
        return true;
    }
  }

  PersonaSetupState copyWith({
    SetupStep? currentStep,
    String? userName,
    int? avatarIndex,
    double? confidenceLevel,
    int? focusGoalIndex,
    bool? isLoading,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return PersonaSetupState(
      currentStep: currentStep ?? this.currentStep,
      userName: userName ?? this.userName,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      focusGoalIndex: focusGoalIndex ?? this.focusGoalIndex,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage,
    );
  }
}
