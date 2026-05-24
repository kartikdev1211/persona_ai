// lib/screens/main/main_shell.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/screens/home/home_screen.dart';
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
    _PlaceholderScreen(label: 'Missions', icon: Icons.bolt_rounded),
    _PlaceholderScreen(label: 'Progress', icon: Icons.bar_chart_rounded),
    _PlaceholderScreen(label: 'Coach', icon: Icons.psychology_rounded),
    _PlaceholderScreen(label: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// Temporary placeholder — delete as you build each real screen
class _PlaceholderScreen extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PlaceholderScreen({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.textDisabled, size: 48),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textDisabled,
                fontFamily: 'Syne',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
