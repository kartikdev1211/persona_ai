abstract class OnboardingEvent {}

class PageChanged extends OnboardingEvent {
  final int index;
  PageChanged(this.index);
}

class CompleteOnboarding extends OnboardingEvent {}
