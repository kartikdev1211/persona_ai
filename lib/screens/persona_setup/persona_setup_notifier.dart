// lib/screens/persona_setup/persona_setup_notifier.dart

import 'package:flutter/cupertino.dart';

enum SetupStep { name, avatar, confidence, focus }

class PersonaSetupNotifier extends ValueNotifier<SetupStep> {
  PersonaSetupNotifier() : super(SetupStep.name);

  String userName = '';
  int avatarIndex = 0;
  double confidenceLevel = 0.5; // 0.0 – 1.0
  int focusGoalIndex = 0;

  bool get isFirst => value == SetupStep.name;
  bool get isLast => value == SetupStep.focus;

  int get stepIndex => SetupStep.values.indexOf(value);
  int get totalSteps => SetupStep.values.length;

  void next() {
    final idx = stepIndex;
    if (idx < totalSteps - 1) {
      value = SetupStep.values[idx + 1];
    }
  }

  void back() {
    final idx = stepIndex;
    if (idx > 0) {
      value = SetupStep.values[idx - 1];
    }
  }

  bool canProceed() {
    switch (value) {
      case SetupStep.name:
        return userName.trim().length >= 2;
      case SetupStep.avatar:
        return true;
      case SetupStep.confidence:
        return true;
      case SetupStep.focus:
        return true;
    }
  }
}
