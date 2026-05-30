// lib/screens/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persona_ai/core/theme/app_colors.dart';
import 'package:persona_ai/core/theme/spacing.dart';
import 'package:persona_ai/screens/splash/bloc/bloc/splash_bloc.dart';
import 'package:persona_ai/screens/splash/bloc/event/splash_event.dart';
import 'package:persona_ai/screens/splash/bloc/state/splash_state.dart';
import 'package:persona_ai/screens/splash/widget/splash_loader.dart';
import 'package:persona_ai/screens/splash/widget/splash_logo.dart';
import 'package:persona_ai/screens/splash/widget/splash_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _bgCtrl;
  late final AnimationController _logoCtrl;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoSlide;
  late final AnimationController _loaderCtrl;
  late final Animation<double> _loaderFade;
  late final Animation<double> _loaderProgress;
  late final AnimationController _exitCtrl;

  @override
  void initState() {
    super.initState();

    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _logoFade = CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOut);
    _logoSlide = CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOutCubic);

    _loaderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _loaderFade = CurvedAnimation(
      parent: _loaderCtrl,
      curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
    );
    _loaderProgress = CurvedAnimation(
      parent: _loaderCtrl,
      curve: const Interval(0.05, 0.95, curve: Curves.easeInOut),
    );

    _exitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _logoCtrl.dispose();
    _loaderCtrl.dispose();
    _exitCtrl.dispose();
    super.dispose();
  }

  Future<void> _onNavigate(String route) async {
    await _logoCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    await _loaderCtrl.forward();
    await _exitCtrl.forward();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(AppStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateTo) {
            _onNavigate(state.route);
          }
        },
        child: FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(_exitCtrl),
          child: Scaffold(
            backgroundColor: AppColors.bg100,
            body: AnimatedBuilder(
              animation: _bgCtrl,
              builder: (_, __) => Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: SplashPainter(progress: _bgCtrl.value),
                    ),
                  ),
                  Center(
                    child: SplashLogo(
                      fadeAnim: _logoFade,
                      slideAnim: _logoSlide,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom:
                        MediaQuery.of(context).padding.bottom + AppSpacing.xl3,
                    child: SplashLoader(
                      fadeAnim: _loaderFade,
                      progressAnim: _loaderProgress,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
