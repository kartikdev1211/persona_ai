import 'package:flutter/material.dart';
import 'package:persona_ai/screens/auth/auth_screen.dart';
import 'package:persona_ai/screens/main/main_shell.dart';
import 'package:persona_ai/screens/onboarding/oboarding_screen.dart';
import 'package:persona_ai/screens/persona_setup/persona_setup_screen.dart';
import 'package:persona_ai/screens/splash/splash_screen.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/auth': (_) => const AuthScreen(),
        '/persona-setup': (_) => const PersonaSetupScreen(),
        '/home': (_) => const MainShell(),
      },
    );
  }
}
