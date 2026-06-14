// lib/screens/persona_setup/bloc/event/persona_setup_event.dart

abstract class PersonaSetupEvent {}

class NameChanged extends PersonaSetupEvent {
  final String name;
  NameChanged(this.name);
}

class ImageSelected extends PersonaSetupEvent {
  final String path;
  ImageSelected(this.path);
}

class ConfidenceChanged extends PersonaSetupEvent {
  final double level;
  ConfidenceChanged(this.level);
}

class FocusGoalChanged extends PersonaSetupEvent {
  final int index;
  FocusGoalChanged(this.index);
}

class NextStep extends PersonaSetupEvent {}

class PreviousStep extends PersonaSetupEvent {}

class FinishSetup extends PersonaSetupEvent {}
