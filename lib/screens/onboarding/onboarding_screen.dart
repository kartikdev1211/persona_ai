// lib/screens/onboarding/onboarding_screen.dart
// CHANGES: removed Goals page, _totalPages = 3, _onSkip goes to auth directly,
//          removed _selectedGoals state, removed onboarding_goals import

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/models/onboarding/onboarding_model.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_navbar.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_slides.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;

  // 3 slides only — goals page removed
  static const int _totalPages = 3;

  List<Color> get _activeGradient => kSlides[_currentPage].gradient;

  void _onNext() {
    if (_currentPage < _totalPages - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _onSkip() => _navigateToAuth();

  void _navigateToAuth() {
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg100,
      body: Stack(
        children: [
          // Ambient glow — shifts color per slide
          _AmbientGlow(gradient: _activeGradient),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageCtrl,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: List.generate(
                      kSlides.length,
                      (i) =>
                          Center(child: OnboardingSlideView(slide: kSlides[i])),
                    ),
                  ),
                ),

                // Nav bar — always canProceed (no goals gate)
                OnboardingNavBar(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  gradient: _activeGradient,
                  onNext: _onNext,
                  onSkip: _onSkip,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  final List<Color> gradient;
  const _AmbientGlow({required this.gradient});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 0.9,
          colors: [gradient.first.withOpacity(0.08), Colors.transparent],
        ),
      ),
    );
  }
}
