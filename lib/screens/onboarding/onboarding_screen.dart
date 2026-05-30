// lib/screens/onboarding/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/routes/app_routes.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/models/onboarding/onboarding_model.dart';
import 'package:persona_ai/screens/onboarding/bloc/bloc/onboarding_bloc.dart';
import 'package:persona_ai/screens/onboarding/bloc/event/onboarding_event.dart';
import 'package:persona_ai/screens/onboarding/bloc/state/onboarding_state.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_navbar.dart';
import 'package:persona_ai/screens/onboarding/widget/onboarding_slides.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageCtrl = PageController();

  // 3 slides only
  static const int _totalPages = 3;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _onNext(BuildContext context, int currentPage) {
    if (currentPage < _totalPages - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.read<OnboardingBloc>().add(CompleteOnboarding());
    }
  }

  void _onSkip(BuildContext context) {
    context.read<OnboardingBloc>().add(CompleteOnboarding());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (prev, curr) => curr.isCompleted,
        listener: (context, state) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
        },
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final activeGradient = kSlides[state.currentPage].gradient;

            return Scaffold(
              backgroundColor: AppColors.bg100,
              body: Stack(
                children: [
                  // Ambient glow — shifts color per slide
                  _AmbientGlow(gradient: activeGradient),

                  SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageCtrl,
                            onPageChanged: (i) => context
                                .read<OnboardingBloc>()
                                .add(PageChanged(i)),
                            children: List.generate(
                              kSlides.length,
                              (i) => Center(
                                child: OnboardingSlideView(slide: kSlides[i]),
                              ),
                            ),
                          ),
                        ),

                        // Nav bar
                        OnboardingNavBar(
                          currentPage: state.currentPage,
                          totalPages: _totalPages,
                          gradient: activeGradient,
                          onNext: () => _onNext(context, state.currentPage),
                          onSkip: () => _onSkip(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
