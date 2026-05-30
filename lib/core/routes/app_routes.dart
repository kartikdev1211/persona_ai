// lib/core/routes/app_routes.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/screens/auth/auth_screen.dart';
import 'package:persona_ai/screens/main/main_shell.dart';
import 'package:persona_ai/screens/onboarding/onboarding_screen.dart';
import 'package:persona_ai/screens/persona_setup/persona_report_screen.dart';
import 'package:persona_ai/screens/persona_setup/persona_setup_screen.dart';
import 'package:persona_ai/screens/profile/edit_profile_screen.dart';
import 'package:persona_ai/screens/profile/personality/archetype_detail_screen.dart';
import 'package:persona_ai/screens/profile/personality/experience_detail_screen.dart';
import 'package:persona_ai/screens/profile/personality/focus_detail_screen.dart';
import 'package:persona_ai/screens/profile/profile_detail_screen.dart';
import 'package:persona_ai/screens/quiz_screen/quiz_screen.dart';
import 'package:persona_ai/screens/splash/splash_screen.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String quiz = '/quiz';
  static const String personaSetup = '/persona-setup';
  static const String personaReport = '/persona-report';
  static const String profileDetail = '/profile-detail';
  static const String editProfile = '/edit-profile';
  static const String archetype = '/archetype';
  static const String focus = '/focus';
  static const String experience = '/experience';
  static const String home = '/home';

  // Route Map
  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    auth: (_) => const AuthScreen(),
    quiz: (_) => const QuizScreen(),
    personaSetup: (_) => const PersonaSetupScreen(),
    personaReport: (_) => const PersonaReportScreen(),
    profileDetail: (_) => const ProfileDetailScreen(),
    editProfile: (_) => const EditProfileScreen(),
    archetype: (_) => const ArchetypeDetailScreen(),
    focus: (_) => const FocusDetailScreen(),
    experience: (_) => const ExperienceDetailScreen(),
    home: (_) => const MainShell(),
  };
}
