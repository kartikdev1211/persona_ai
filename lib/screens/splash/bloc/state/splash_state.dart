abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateTo extends SplashState {
  final String route;
  SplashNavigateTo(this.route);
}
