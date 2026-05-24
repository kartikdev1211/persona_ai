// lib/features/onboarding/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/models/onboarding/onboarding_model.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_goals.dart';
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
  List<int> _selectedGoals = [];

  // total pages = 3 slides + 1 goals
  static const int _totalPages = 4;

  List<Color> get _activeGradient {
    if (_currentPage < kSlides.length) {
      return kSlides[_currentPage].gradient;
    }
    return AppColors.primaryGradient;
  }

  bool get _canProceed {
    if (_currentPage == _totalPages - 1) return _selectedGoals.isNotEmpty;
    return true;
  }

  void _onNext() {
    if (!_canProceed) return;
    if (_currentPage < _totalPages - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _onSkip() {
    _pageCtrl.animateToPage(
      _totalPages - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _navigateToAuth() {
    // Replace with your router
    // context.go('/auth');
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
          // ── Ambient background glow ──────────
          _AmbientGlow(gradient: _activeGradient),

          // ── Pages ────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageCtrl,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [
                      // 3 intro slides
                      ...List.generate(
                        kSlides.length,
                        (i) => Center(
                          child: OnboardingSlideView(slide: kSlides[i]),
                        ),
                      ),

                      // Goals page
                      SingleChildScrollView(
                        child: OnboardingGoalsPage(
                          onSelectionChanged: (s) =>
                              setState(() => _selectedGoals = s),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Nav bar ──────────────────
                OnboardingNavBar(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  gradient: _activeGradient,
                  onNext: _onNext,
                  onSkip: _onSkip,
                  canProceed: _canProceed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Animated ambient glow that changes color per slide
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
