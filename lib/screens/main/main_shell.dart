// lib/screens/main/main_shell.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/screens/home/home_screen.dart';
import 'package:persona_ai/screens/coach/coach_screen.dart';
import 'package:persona_ai/screens/missions/missions_screen.dart';
import 'package:persona_ai/screens/progress/progress_screen.dart';
import 'package:persona_ai/screens/profile/profile_screen.dart';
import 'package:persona_ai/screens/profile/bloc/bloc/profile_bloc.dart';
import 'package:persona_ai/screens/profile/bloc/event/profile_event.dart';
import 'widget/app_bottom_nav.dart';

// import '../missions/missions_screen.dart';
// import '../progress/progress_screen.dart';
// import '../coach/coach_screen.dart';
// import '../profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Keep pages alive when switching tabs
  final _navigatorKeys = List.generate(5, (_) => GlobalKey<NavigatorState>());

  final _pages = const [
    HomeScreen(),
    MissionsScreen(),
    ProgressScreen(),
    CoachScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
          // Trigger profile fetch when switching to profile tab
          if (i == 4) {
            context.read<ProfileBloc>().add(const FetchProfile());
          }
        },
      ),
    );
  }
}
